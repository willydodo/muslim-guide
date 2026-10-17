import 'package:muslim_guide/features/hijri/data/hijri_events_data.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_event.dart';
import 'package:muslim_guide/features/hijri/domain/repositories/hijri_repository.dart';
import 'package:muslim_guide/features/hijri/domain/services/hijri_calculator.dart';

/// Repository implementation over [HijriCalculator] (DEC-0033).
class HijriRepositoryImpl implements HijriRepository {
  /// Creates a repository.
  new({
    required this._calculator,
    this._adjustment = 0,
  }) : assert(
         _adjustment >= -1 && _adjustment <= 1,
         'adjustment must be -1, 0, or +1 (REQ-HIJRI-001).',
       );

  final HijriCalculator _calculator;
  final int _adjustment;

  @override
  Future<HijriDate> getToday() {
    return fromGregorian(DateTime.now());
  }

  @override
  Future<HijriDate> fromGregorian(DateTime date) async {
    final adjusted = date.add(Duration(days: _adjustment));
    return _calculator.fromGregorian(adjusted);
  }

  @override
  List<HijriEvent> getEventsForMonth(int year, int month) {
    return kHijriEvents.where((event) => event.month == month).toList();
  }

  @override
  List<HijriEvent> getUpcomingEvents({int limit = 3}) {
    final today = _calculator.fromGregorian(DateTime.now());
    final ranked = kHijriEvents.toList()..sort((a, b) {
      return _daysUntil(today, a).compareTo(_daysUntil(today, b));
    });
    return ranked.take(limit).toList();
  }

  /// Days from [today] until [event]'s next occurrence (0-354).
  int _daysUntil(HijriDate today, HijriEvent event) {
    var yearOffset = 0;
    if (event.month < today.month ||
        (event.month == today.month && event.day < today.day)) {
      yearOffset = 1;
    }
    final eventOrdinal =
        yearOffset * 354 + _monthOrdinal(event.month, event.day);
    final todayOrdinal = _monthOrdinal(today.month, today.day);
    return eventOrdinal - todayOrdinal;
  }

  /// Approximate ordinal within a Hijri year (29.5-day mean months).
  ///
  /// Used only for ranking upcoming events, never for calendar display.
  int _monthOrdinal(int month, int day) {
    return ((month - 1) * 29.5).round() + day;
  }
}
