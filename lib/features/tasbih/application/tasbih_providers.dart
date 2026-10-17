import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/app/providers/bootstrap_provider.dart';
import 'package:muslim_guide/features/tasbih/data/tasbih_loader.dart';
import 'package:muslim_guide/features/tasbih/data/tasbih_repository.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_entry.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_pack.dart';

export 'package:muslim_guide/features/tasbih/data/tasbih_repository.dart'
    show MemoryTasbihStorage;

/// Provides the tasbih pack loader backed by the root asset bundle.
final tasbihLoaderProvider = Provider<TasbihLoader>(
  (ref) => TasbihLoader(assetBundle: rootBundle),
);

/// Verified tasbih pack when shipped, null/empty while pending approval.
///
/// keepAlive: static bundled pack (or its absence).
final AsyncNotifierProvider<TasbihListNotifier, TasbihPack?>
    tasbihListProvider =
    AsyncNotifierProvider<TasbihListNotifier, TasbihPack?>(
  TasbihListNotifier.new,
);

/// Loads the bundled pack once (pending/empty while awaiting shaykh-1).
class TasbihListNotifier extends AsyncNotifier<TasbihPack?> {
  @override
  Future<TasbihPack?> build() {
    ref.keepAlive();
    return ref.watch(tasbihLoaderProvider).load();
  }
}

/// Counter storage over the shared settings box (null before bootstrap).
final tasbihCounterStorageProvider = Provider<TasbihStorage>((ref) {
  return HiveTasbihStorage(ref.watch(hiveStoreProvider)?.settingsBox);
});

/// Counter repository over [tasbihCounterStorageProvider].
final Provider<TasbihRepository> tasbihCounterRepositoryProvider =
    Provider<TasbihRepository>(
  (ref) => TasbihRepository(
    storage: ref.watch(tasbihCounterStorageProvider),
  ),
);

/// Live counter session for one entry (autoDispose: refreshed on entry).
final AutoDisposeNotifierProviderFamily<TasbihSessionNotifier, TasbihSession,
    TasbihSessionArg> tasbihSessionProvider = NotifierProvider.autoDispose
    .family<TasbihSessionNotifier, TasbihSession, TasbihSessionArg>(
  TasbihSessionNotifier.new,
);

/// Argument for [tasbihSessionProvider]: entry id + target.
@immutable
class TasbihSessionArg {
  /// Creates a session argument.
  const new({required this.id, required this.target});

  /// Entry id.
  final String id;

  /// Target repetitions.
  final int target;

  @override
  bool operator ==(Object other) =>
      other is TasbihSessionArg && other.id == id && other.target == target;

  @override
  int get hashCode => Object.hash(id, target);
}

/// Reads and advances the on-screen tasbih counter.
class TasbihSessionNotifier
    extends AutoDisposeFamilyNotifier<TasbihSession, TasbihSessionArg> {
  @override
  TasbihSession build(TasbihSessionArg arg) {
    final stored =
        ref.watch(tasbihCounterRepositoryProvider).storage.read(
              TasbihRepository.countKey(arg.id),
            );
    final count = stored is num ? stored.toInt().clamp(0, arg.target) : 0;
    return TasbihSession(count: count, target: arg.target);
  }

  /// Increments by one (capped at target) and persists.
  Future<void> increment() async {
    final next = await ref
        .read(tasbihCounterRepositoryProvider)
        .increment(arg.id, target: arg.target);
    state = TasbihSession(count: next, target: arg.target);
  }

  /// Deletes the saved count (E-3: UI confirms before calling).
  Future<void> reset() async {
    await ref.read(tasbihCounterRepositoryProvider).reset(arg.id);
    state = TasbihSession(count: 0, target: arg.target);
  }
}

/// Entry lookup helper for screens.
final ProviderFamily<TasbihEntry?, String> tasbihEntryProvider =
    Provider.family<TasbihEntry?, String>((ref, id) {
  final pack = ref.watch(tasbihListProvider).valueOrNull;
  return pack?.entryById(id);
});
