import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_event.dart';

/// Repository for Hijri dates and events (DEC-0033).
abstract class HijriRepository {
  /// Returns the current Hijri date with the user adjustment applied.
  Future<HijriDate> getToday();

  /// Returns the Hijri date for Gregorian [date], adjusted.
  Future<HijriDate> fromGregorian(DateTime date);

  /// Returns events falling in Hijri ([year], [month]).
  List<HijriEvent> getEventsForMonth(int year, int month);

  /// Returns the next [limit] upcoming events from today.
  List<HijriEvent> getUpcomingEvents({int limit = 3});
}
