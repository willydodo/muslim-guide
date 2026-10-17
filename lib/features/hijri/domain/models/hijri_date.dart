import 'package:meta/meta.dart';

/// A Hijri (Islamic calendar) date as computed by the Umm al-Qura tables
/// bundled inside the `hijri` package (DEC-0033).
///
/// Pure Dart value object: no Flutter, no packages. The optional
/// user adjustment (±1 day per REQ-HIJRI-001) is applied by the data
/// layer before construction, so this model always holds the final date.
@immutable
class HijriDate {
  /// Creates a Hijri date.
  const new({
    required this.year,
    required this.month,
    required this.day,
  }) : assert(year > 0, 'Hijri year must be positive.'),
       assert(month >= 1 && month <= 12, 'Hijri month must be 1-12.'),
       assert(day >= 1 && day <= 30, 'Hijri day must be 1-30.');

  /// Hijri year (e.g. 1447).
  final int year;

  /// Hijri month (1 = Muharram … 12 = Dhu al-Hijjah).
  final int month;

  /// Day of month (1-30).
  final int day;

  @override
  bool operator ==(Object other) {
    return other is HijriDate &&
        other.year == year &&
        other.month == month &&
        other.day == day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => '$year/$month/$day';
}
