import 'package:hijri/hijri_calendar.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';
import 'package:muslim_guide/features/hijri/domain/services/hijri_calculator.dart';

/// Umm al-Qura calculator backed by the `hijri` package (DEC-0033, CR-0019).
///
/// Each method creates a fresh [HijriCalendar] so the package's static
/// mutable locale never leaks between calls. The user adjustment
/// (±1 day, REQ-HIJRI-001) shifts the Gregorian date before conversion,
/// which keeps month lengths and weekday mapping consistent.
///
/// Valid range: 1356–1500 AH (1937–2077 CE) per the bundled table.
class HijriCalculatorImpl implements HijriCalculator {
  /// Creates a calculator with user adjustment in days (-1, 0, +1).
  new({int adjustment = 0}) : _adjustment = adjustment {
    if (adjustment < -1 || adjustment > 1) {
      throw ArgumentError.value(
        adjustment,
        'adjustment',
        'Expected -1, 0, or +1 (REQ-HIJRI-001).',
      );
    }
  }

  final int _adjustment;

  @override
  HijriDate fromGregorian(DateTime date) {
    final shifted = date.add(Duration(days: _adjustment));
    final hijri = HijriCalendar.fromDate(shifted);
    return HijriDate(
      year: hijri.hYear,
      month: hijri.hMonth,
      day: hijri.hDay,
    );
  }

  @override
  DateTime toGregorian(HijriDate date) {
    final hijri = HijriCalendar()
      ..hYear = date.year
      ..hMonth = date.month
      ..hDay = date.day;
    final gregorian = hijri.hijriToGregorian(date.year, date.month, date.day);
    return gregorian.add(Duration(days: -_adjustment));
  }

  @override
  int monthLength(int year, int month) {
    final probe = HijriCalendar();
    return probe.getDaysInMonth(year, month);
  }
}
