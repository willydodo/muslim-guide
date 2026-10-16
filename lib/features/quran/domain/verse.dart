/// A single Quranic verse (ayah) from the bundled Uthmani asset.
///
/// The [text] is preserved verbatim from
/// `assets/content/quran/quran-uthmani.json` (Phase 06 Task 2 decision:
/// display literally — no basmala splitting, no normalization).
class Verse {
  /// Creates a verse.
  const new({
    required this.surahId,
    required this.number,
    required this.text,
  });

  /// Creates a verse from decoded JSON within surah [surahId].
  factory fromJson(Map<String, dynamic> json, {required int surahId}) {
    final rawNumber = json['id'];
    if (rawNumber is! num || rawNumber.toInt() <= 0) {
      throw FormatException(
        'Verse "id" must be a positive number (surah $surahId).',
      );
    }
    final rawText = json['text'];
    if (rawText is! String || rawText.isEmpty) {
      throw FormatException(
        'Verse "text" must be a non-empty string (surah $surahId).',
      );
    }
    return Verse(
      surahId: surahId,
      number: rawNumber.toInt(),
      text: rawText,
    );
  }

  /// Owning surah id (1-114).
  final int surahId;

  /// Ayah number within the surah (1-based).
  final int number;

  /// Uthmani text, verbatim from the asset.
  final String text;
}
