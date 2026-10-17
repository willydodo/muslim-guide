/// A single tasbih entry (Phase 05c).
///
/// Real Arabic text comes only from the verified HadeethEnc pack
/// (`assets/content/tasbih/tasbih.json`, PENDING_REVIEW). The loader gates
/// on review status — this model never carries placeholder religious text.
class TasbihEntry {
  /// Creates a tasbih entry.
  const new({
    required this.id,
    required this.dhikr,
    required this.target,
    required this.hadeeth,
    required this.grade,
    required this.sourceRef,
    required this.section,
  });

  /// Creates an entry from the decoded tasbih pack JSON item.
  factory fromJson(Map<String, dynamic> json) {
    String requiredString(String key) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
      throw FormatException(
        'Tasbih entry field "$key" must be a non-empty string.',
      );
    }

    int requiredCount(String key) {
      final value = json[key];
      if (value is num && value.toInt() > 0) {
        return value.toInt();
      }
      throw FormatException(
        'Tasbih entry field "$key" must be a positive number.',
      );
    }

    final section = requiredString('section');
    if (section != 'after_prayer' && section != 'free') {
      throw const FormatException(
        'Tasbih entry "section" must be after_prayer or free.',
      );
    }

    return TasbihEntry(
      id: requiredString('id'),
      dhikr: requiredString('dhikr'),
      target: requiredCount('repeat'),
      hadeeth: requiredString('arabic'),
      grade: requiredString('grade_simple'),
      sourceRef: requiredString('source_ref'),
      section: section,
    );
  }

  /// Stable identifier (e.g. subhanallah).
  final String id;

  /// Short dhikr text for the counter display.
  final String dhikr;

  /// Target repetitions (33/34/100).
  final int target;

  /// Full hadeeth text (evidence, shown on detail).
  final String hadeeth;

  /// Coarse grade (صحيح / review_required).
  final String grade;

  /// Source reference (HadeethEnc id + attribution).
  final String sourceRef;

  /// 'after_prayer' (33/33/34 sequence) or 'free' (100x).
  final String section;

  /// True when cleared for display by shaykh-1 review.
  bool get isApproved => grade != 'review_required';
}
