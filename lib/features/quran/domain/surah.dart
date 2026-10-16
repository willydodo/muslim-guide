import 'package:muslim_guide/features/quran/domain/verse.dart';

/// Revelation location of a surah, as labeled in the bundled asset.
enum RevelationType {
  /// Revealed in Mecca.
  meccan('meccan'),

  /// Revealed in Medina.
  medinan('medinan');

  /// Creates a revelation type.
  /// Explicit const form required for value-carrying entries (file errors
  /// without it); the two lints contradict the project `const new(...)`
  /// mandate here, so both are suppressed with justification.
  // ignore: unnecessary_const_in_enum_constructor, unnecessary_type_name_in_constructor // Explicit const form required for value-carrying entries; lints contradict the project const new(...) mandate (phases/02.md deviation).
  const RevelationType(this.value);

  /// Stable JSON value.
  final String value;

  /// Resolves [value] to a type, or null when unknown.
  static RevelationType? fromValue(String? value) {
    for (final type in values) {
      if (type.value == value) return type;
    }
    return null;
  }
}

/// A surah entry with its verses, parsed from the bundled Quran JSON.
///
/// Integrity is enforced at parse time: [verseCount] must match the
/// decoded verses, and verse numbers must be sequential from 1.
class Surah {
  /// Creates a surah.
  const new({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.verseCount,
    required this.revelation,
    required this.order,
    required this.verses,
  });

  /// Creates a surah from decoded JSON.
  factory fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    if (rawId is! num || rawId.toInt() < 1 || rawId.toInt() > 114) {
      throw FormatException('Surah "id" must be within 1-114: $rawId');
    }
    final id = rawId.toInt();

    final rawNameAr = json['name_ar'];
    if (rawNameAr is! String || rawNameAr.isEmpty) {
      throw FormatException(
        'Surah "name_ar" must be a non-empty string (surah $id).',
      );
    }

    final rawNameEn = json['name_en'];
    if (rawNameEn is! String || rawNameEn.isEmpty) {
      throw FormatException(
        'Surah "name_en" must be a non-empty string (surah $id).',
      );
    }

    final rawCount = json['verse_count'];
    if (rawCount is! num || rawCount.toInt() <= 0) {
      throw FormatException(
        'Surah "verse_count" must be a positive number (surah $id).',
      );
    }

    final revelation = RevelationType.fromValue(
      json['revelation'] is String ? json['revelation'] as String : null,
    );
    if (revelation == null) {
      throw FormatException(
        'Surah "revelation" is unknown (surah $id): '
        "${json['revelation']}",
      );
    }

    final rawOrder = json['order'];
    if (rawOrder is! num || rawOrder.toInt() <= 0) {
      throw FormatException(
        'Surah "order" must be a positive number (surah $id).',
      );
    }

    final rawVerses = json['verses'];
    if (rawVerses is! List<dynamic>) {
      throw FormatException('Surah "verses" must be a list (surah $id).');
    }
    if (rawVerses.length != rawCount.toInt()) {
      throw FormatException(
        'Surah $id declares ${rawCount.toInt()} verses but carries '
        '${rawVerses.length}.',
      );
    }
    final verses = <Verse>[];
    for (var index = 0; index < rawVerses.length; index++) {
      final rawVerse = rawVerses[index];
      if (rawVerse is! Map<String, dynamic>) {
        throw FormatException(
          'Each verse must be a JSON object (surah $id).',
        );
      }
      final verse = Verse.fromJson(rawVerse, surahId: id);
      if (verse.number != index + 1) {
        throw FormatException(
          'Surah $id verses must be sequential from 1 '
          '(found ${verse.number} at position ${index + 1}).',
        );
      }
      verses.add(verse);
    }

    return Surah(
      id: id,
      nameAr: rawNameAr,
      nameEn: rawNameEn,
      verseCount: rawCount.toInt(),
      revelation: revelation,
      order: rawOrder.toInt(),
      verses: List<Verse>.unmodifiable(verses),
    );
  }

  /// Surah id (1-114).
  final int id;

  /// Arabic surah name from the asset metadata (not verse text).
  final String nameAr;

  /// English surah name from the asset metadata.
  final String nameEn;

  /// Declared verse count (always equals [verses] length).
  final int verseCount;

  /// Revelation location.
  final RevelationType revelation;

  /// Chronological revelation order from the asset metadata.
  final int order;

  /// Verses in mushaf order.
  final List<Verse> verses;
}
