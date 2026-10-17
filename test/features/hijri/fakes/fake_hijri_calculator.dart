import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';
import 'package:muslim_guide/features/hijri/domain/services/hijri_calculator.dart';

/// Deterministic fake calculator for tests.
///
/// Maps Gregorian dates through a fixed offset table so tests never
/// depend on the `hijri` package's static mutable state.
class FakeHijriCalculator implements HijriCalculator {
  /// Creates a fake with an optional day shift applied to conversions.
  new({this.shiftDays = 0});

  /// Days added to Gregorian inputs before conversion.
  final int shiftDays;

  @override
  HijriDate fromGregorian(DateTime date) {
    // Fixed anchor: 2024-06-15 (Gregorian) == 1445-12-09 (Hijri).
    // Tests shift from this anchor deterministically.
    final base = DateTime(2024, 6, 15).add(Duration(days: shiftDays));
    final delta = date.difference(base).inDays;
    var day = 9 + delta;
    var month = 12;
    var year = 1445;
    while (day > 30) {
      day -= 30;
      month += 1;
      if (month > 12) {
        month = 1;
        year += 1;
      }
    }
    while (day < 1) {
      day += 30;
      month -= 1;
      if (month < 1) {
        month = 12;
        year -= 1;
      }
    }
    return HijriDate(year: year, month: month, day: day);
  }

  @override
  DateTime toGregorian(HijriDate date) {
    const baseHijri = HijriDate(year: 1445, month: 12, day: 9);
    final delta =
        (date.year - baseHijri.year) * 354 +
        (date.month - baseHijri.month) * 30 +
        (date.day - baseHijri.day);
    return DateTime(2024, 6, 15).add(Duration(days: delta - shiftDays));
  }

  @override
  int monthLength(int year, int month) => 30;
}
