# Dependencies

## Each Dependency
- purpose
- version constraint (مثبتة صراحة)
- license review
- maintenance review
- security review
- owner/usage location

## Rules
- لا `latest`.
- FVM أو ما يعادله.
- حزمة غير مستخدمة = تُحذف.
- حزمة غير مدرجة في `LICENSES.md` = **BLOCK**.

## Register (Phase 00 — 2026-10-05)

حزم مباشرة:

| Package | Purpose | Constraint | License | Verified | Location |
|---|---|---|---|---|---|
| audio_service | Background Adhan playback service (CR-0012) | `0.18.19` (exact) | MIT (+ Apache-2.0 ExoPlayer) | 2026-10-10 — https://pub.dev/packages/audio_service/versions/0.18.19 | `pubspec.yaml`; Phase 04 Task 5 |
| audio_session | AudioSession config + interruption/noisy watchers (CR-0014, Task 6) | `0.2.4` (exact) | MIT | 2026-10-11 — https://pub.dev/packages/audio_session/versions/0.2.4 (published 2026-06-29T13:10:31.881382Z) | `pubspec.yaml`; Phase 04 Task 6 |
| flutter_riverpod | State management (DEC-0002، DEC-0016) | `2.6.1` (exact) | MIT | 2026-10-05 — https://pub.dev/packages/flutter_riverpod/versions/2.6.1 | `pubspec.yaml` dependencies |
| flutter_localizations | Localization (Phase 01) | Flutter SDK | BSD-style (BSD-3-Clause text) | Flutter SDK | `pubspec.yaml` dependencies |
| flutter_local_notifications | Scheduled local notifications (DEC-0009, CR-0012) | `22.3.1` (exact) | BSD-3-Clause | 2026-10-10 — https://pub.dev/packages/flutter_local_notifications/versions/22.3.1 | `pubspec.yaml`; Phase 04 Tasks 3–4 |
| go_router | Navigation (DEC-0003) | `18.0.2` (exact) | BSD-3-Clause | 2026-10-07 — https://pub.dev/packages/go_router/versions/18.0.2 (published 2026-09-28) | `pubspec.yaml`; `lib/app/router.dart` |
| hive_ce | Local key-value storage (DEC-0024، DEC-0027) | `2.20.2` (exact) | BSD-3-Clause (+ Apache-2.0 embedded component) | 2026-10-06 — https://pub.dev/packages/hive_ce/versions/2.20.1 | `pubspec.yaml` dependencies |
| hive_ce_flutter | Initialize Hive in Flutter | `2.4.0` (exact) | BSD-3-Clause; older portions Apache-2.0 | 2026-10-06 — https://pub.dev/packages/hive_ce_flutter/versions/2.4.0 | `pubspec.yaml` dependencies |
| intl | Locale-aware number formatting (DEC-0026) | `0.20.3` (exact) | BSD-3-Clause | 2026-10-06 — https://pub.dev/packages/intl/versions/0.20.3 | `pubspec.yaml` dependencies |
| just_audio | Adhan audio playback (CR-0012) | `0.10.6` (exact) | MIT (+ Apache-2.0 ExoPlayer) | 2026-10-10 — https://pub.dev/packages/just_audio/versions/0.10.6 | `pubspec.yaml`; Phase 04 Task 5 |
| path_provider | Hive and local error-log paths (CR-0006) | `2.1.6` (exact) | BSD-3-Clause | 2026-10-06 — https://pub.dev/packages/path_provider/versions/2.1.6 | `pubspec.yaml` dependencies |
| share_plus | Export local error log (DEC-0025) | `13.3.1` (exact) | BSD-3-Clause | 2026-10-06 — https://pub.dev/packages/share_plus/versions/13.3.1 | `pubspec.yaml` dependencies |
| timezone | IANA timezone database for Phase 01 bootstrap and notification scheduling (CR-0008, CR-0012) | `0.11.1` (exact) | BSD-2-Clause | 2026-10-10 — https://pub.dev/packages/timezone/versions/0.11.1 (published 2026-06-29) | `pubspec.yaml`; `lib/app/providers/bootstrap_provider.dart`; Phase 04 Task 4 |
| geolocator | GPS and location services for Task 3 (CR-0009) | `14.1.1` (exact) | MIT | 2026-10-08 — https://pub.dev/packages/geolocator/versions/14.1.1 | `pubspec.yaml` dependencies |
| flutter_compass | Qibla compass heading for Phase 03 (CR-0011) | `0.8.1` (exact) | MIT | 2026-10-09 — https://pub.dev/packages/flutter_compass/versions/0.8.1 (published 2024-11-17, latest) | `pubspec.yaml` dependencies |
| geolocator_platform_interface | Test-only fake platform contract for geolocator | `4.4.0` (exact, dev) | BSD-3-Clause | 2026-10-08 — https://pub.dev/packages/geolocator_platform_interface/versions/4.4.0 | `pubspec.yaml` dev_dependencies; `test/features/location/fakes/fake_geolocator_platform.dart` |
| hijri | Umm al-Qura Hijri calendar + user adjustment ±1 (DEC-0033) | `3.0.1` (exact) | BSD-2-Clause | 2026-10-17 — https://pub.dev/packages/hijri/versions/3.0.1 | `pubspec.yaml` dependencies; `lib/features/hijri/` |
| very_good_analysis | قواعد التحليل الساكن (DEC-0011) | `11.0.0` (exact) | MIT | 2026-10-05 — https://pub.dev/packages/very_good_analysis | `pubspec.yaml` dev_dependencies |

تبعيات غير مباشرة (تُستنتَج فعليًا من `pubspec.lock`):

| Package | License | Verified |
|---|---|---|
| riverpod | MIT | 2026-10-05 — https://pub.dev/packages/riverpod |
| state_notifier | MIT | 2026-10-05 — https://pub.dev/packages/state_notifier |
| collection | BSD-3-Clause | 2026-10-05 — https://pub.dev/packages/collection |
| meta | BSD-3-Clause | 2026-10-05 — https://pub.dev/packages/meta |

ملاحظة: القائمة الكاملة لجميع تبعيات `pubspec.lock` مع التراخيص تُوثَّق في `LICENSES.md` (المصدر الوحيد: `03-decisions.md` DEC-0014 … DEC-0018).