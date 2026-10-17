import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';

/// Abstract calculator for Hijri dates (Umm al-Qura, DEC-0033).
///
/// Implemented by `HijriCalculatorImpl` which wraps the `hijri` package.
/// The abstraction keeps the static mutable state of the package out of
/// the domain and allows injecting fakes in tests.
abstract class HijriCalculator {
  /// Returns the Hijri date for Gregorian [date].
  HijriDate fromGregorian(DateTime date);

  /// Returns the Gregorian date for Hijri [date].
  DateTime toGregorian(HijriDate date);

  /// Returns the number of days in Hijri [month] of [year].
  int monthLength(int year, int month);
}
