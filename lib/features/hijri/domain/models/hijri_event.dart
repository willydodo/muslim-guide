import 'package:meta/meta.dart';

/// A Hijri calendar event (e.g. Ramadan start, Eid).
///
/// Pure Dart value object: no Flutter. Dates are Hijri month/day pairs;
/// the user adjustment (±1 day, REQ-HIJRI-001) is applied at query time
/// by the repository. Display names come from ARB via [nameKey] — never
/// hardcoded here (architecture/07-localization.md).
@immutable
class HijriEvent {
  /// Creates an event.
  const new({required this.month, required this.day, required this.nameKey})
    : assert(month >= 1 && month <= 12, 'Hijri month must be 1-12.'),
      assert(day >= 1 && day <= 30, 'Hijri day must be 1-30.');

  /// Hijri month (1-12).
  final int month;

  /// Hijri day (1-30).
  final int day;

  /// ARB key for the event name (e.g. `event_ramadan_start`).
  final String nameKey;
}
