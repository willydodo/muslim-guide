import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/features/quran/data/quran_asset_loader.dart';
import 'package:muslim_guide/features/quran/data/quran_repository.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';

/// Provides the asset loader backed by the root asset bundle.
///
/// Overridden in tests with a fake bundle; matches the azkar pack loader
/// provider pattern.
final quranAssetLoaderProvider = Provider<QuranAssetLoader>(
  (ref) => QuranAssetLoader(assetBundle: rootBundle),
);

/// Provides the Quran repository over [quranAssetLoaderProvider].
final quranRepositoryProvider = Provider<QuranRepository>(
  (ref) => QuranRepository(ref.watch(quranAssetLoaderProvider)),
);

/// Quran index (114 metadata rows + attribution).
///
/// keepAlive: heavy bundled index shared by index and reader screens.
final AsyncNotifierProvider<QuranIndexNotifier, QuranIndex>
    quranIndexProvider =
    AsyncNotifierProvider<QuranIndexNotifier, QuranIndex>(
  QuranIndexNotifier.new,
);

/// Loads the bundled index once via [quranRepositoryProvider].
class QuranIndexNotifier extends AsyncNotifier<QuranIndex> {
  @override
  Future<QuranIndex> build() {
    ref.keepAlive();
    return ref.watch(quranRepositoryProvider).getIndex();
  }
}

/// Single surah with full verse text (Classic Riverpod, no code gen).
///
/// autoDispose family: released when the reader screen is popped.
final AutoDisposeFutureProviderFamily<Surah, int> surahProvider =
    FutureProvider.autoDispose.family<Surah, int>(
  (ref, id) => ref.watch(quranRepositoryProvider).getSurah(id),
);
