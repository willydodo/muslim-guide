import 'package:muslim_guide/features/quran/data/quran_asset_loader.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';

/// Lightweight surah entry for the index screen (metadata only).
class SurahSummary {
  /// Creates a lightweight surah entry.
  const new({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.verseCount,
    required this.revelation,
  });

  /// Creates a summary from a full surah entry.
  factory fromSurah(Surah surah) {
    return SurahSummary(
      id: surah.id,
      nameAr: surah.nameAr,
      nameEn: surah.nameEn,
      verseCount: surah.verseCount,
      revelation: surah.revelation,
    );
  }

  /// Surah id (1-114).
  final int id;

  /// Arabic surah name from the asset metadata (not verse text).
  final String nameAr;

  /// English surah name from the asset metadata.
  final String nameEn;

  /// Declared verse count.
  final int verseCount;

  /// Revelation location.
  final RevelationType revelation;
}

/// Index payload: 114 metadata rows plus the license attribution.
class QuranIndex {
  /// Creates an index.
  const new({
    required this.surahs,
    required this.totalVerses,
    required this.source,
    required this.license,
  });

  /// Surah metadata rows in mushaf order.
  final List<SurahSummary> surahs;

  /// Total verse count across all surahs (6236 for the bundled asset).
  final int totalVerses;

  /// Content source label (Tanzil.net).
  final String source;

  /// Content license label (CC BY 3.0).
  final String license;
}

/// Repository over [QuranAssetLoader].
///
/// The loader caches the parsed asset, so both methods share the same
/// in-memory list; [QuranIndex] carries metadata only while [getSurah]
/// exposes the full verse text.
class QuranRepository {
  /// Creates a repository.
  new(this.loader);

  /// Underlying asset loader.
  final QuranAssetLoader loader;

  /// Returns the 114-row index with attribution.
  Future<QuranIndex> getIndex() async {
    final surahs = await loader.load();
    return QuranIndex(
      surahs: List<SurahSummary>.unmodifiable(
        surahs.map(SurahSummary.fromSurah),
      ),
      totalVerses: surahs.fold<int>(0, (sum, surah) {
        return sum + surah.verses.length;
      }),
      source: 'Tanzil.net',
      license: 'CC BY 3.0',
    );
  }

  /// Returns the surah [id] with all its verses.
  ///
  /// Throws [ArgumentError] when [id] is outside 1-114.
  Future<Surah> getSurah(int id) async {
    final surahs = await loader.load();
    for (final surah in surahs) {
      if (surah.id == id) return surah;
    }
    throw ArgumentError.value(id, 'id', 'Surah id must be within 1-114.');
  }
}
