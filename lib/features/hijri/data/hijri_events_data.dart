import 'package:muslim_guide/features/hijri/domain/models/hijri_event.dart';

/// Fixed Hijri calendar events (dates only; names via ARB).
///
/// Display names resolve through [HijriEvent.nameKey] in `app_*.arb` —
/// never hardcoded. The user adjustment (±1 day) is applied at query
/// time by the repository, not stored here.
const List<HijriEvent> kHijriEvents = <HijriEvent>[
  HijriEvent(month: 9, day: 1, nameKey: 'event_ramadan_start'),
  HijriEvent(month: 10, day: 1, nameKey: 'event_eid_fitr'),
  HijriEvent(month: 12, day: 9, nameKey: 'event_arafah'),
  HijriEvent(month: 12, day: 10, nameKey: 'event_eid_adha'),
  HijriEvent(month: 1, day: 1, nameKey: 'event_hijri_new_year'),
  HijriEvent(month: 3, day: 12, nameKey: 'event_mawlid'),
  HijriEvent(month: 7, day: 27, nameKey: 'event_isra_miraj'),
  HijriEvent(month: 8, day: 15, nameKey: 'event_mid_shaban'),
];
