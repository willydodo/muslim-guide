import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';

/// Repository for Hijri dates (DEC-0033).
abstract class HijriRepository {
  /// Returns the current Hijri date with the user adjustment applied.
  Future<HijriDate> getToday();

  /// Returns the Hijri date for Gregorian [date], adjusted.
  Future<HijriDate> fromGregorian(DateTime date);
}
