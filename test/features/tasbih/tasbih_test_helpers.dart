import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/app/theme/app_theme.dart';
import 'package:muslim_guide/features/tasbih/application/tasbih_providers.dart';
import 'package:muslim_guide/features/tasbih/data/tasbih_repository.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_entry.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_pack.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Test-only tasbih entries (no religious text — display labels only).
TasbihPack stubTasbihPack() {
  TasbihEntry entry(String id, String section, int target) {
    return TasbihEntry(
      id: id,
      dhikr: 'DHIKR-$id',
      target: target,
      hadeeth: 'HADEETH-$id',
      grade: 'صحيح',
      sourceRef: 'TEST-SOURCE',
      section: section,
    );
  }

  return TasbihPack(
    entries: [
      entry('subhanallah', 'after_prayer', 33),
      entry('alhamdulillah', 'after_prayer', 33),
      entry('allahuakbar', 'after_prayer', 34),
      entry('free-one', 'free', 100),
    ],
  );
}

/// Pack override serving an in-memory [pack] (null = pending pack).
Override tasbihPackOverride(TasbihPack? pack) {
  return tasbihListProvider.overrideWith(
    () => _FixedTasbihList(pack),
  );
}

/// In-memory list notifier used by widget tests.
class _FixedTasbihList extends TasbihListNotifier {
  /// Creates a fixed list.
  new(this.pack);

  /// Pack to serve (null = pending pack Empty state).
  final TasbihPack? pack;

  @override
  Future<TasbihPack?> build() async => pack;
}

/// Repository override backed by [storage].
Override tasbihRepositoryOverride(TasbihStorage storage) {
  return tasbihCounterRepositoryProvider.overrideWithValue(
    TasbihRepository(storage: storage),
  );
}

/// Wraps [child] with ProviderScope, theme, delegates, and locale.
Widget buildTasbihTestApp({
  required Widget child,
  List<Override> overrides = const <Override>[],
  Locale locale = const Locale('ar'),
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}
