/// A single Quranic verse (ayah) from the bundled Uthmani asset.
///
/// The [text] comes from `assets/content/quran/quran-uthmani.json`. The JSON
/// itself is never modified (Tanzil "do not modify" term); the asset loader
/// only separates the basmala display header for surahs other than 1 and 9,
/// so verse 1 of those surahs carries the verse text without the header.
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

  /// Uthmani text from the asset (basmala header separated by the loader
  /// for surahs other than 1 and 9).
  final String text;

  /// Returns a copy with [text] replaced.
  Verse copyWith({String? text}) {
    return Verse(surahId: surahId, number: number, text: text ?? this.text);
  }
}
