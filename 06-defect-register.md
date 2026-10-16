# Defect Register

> **ملاحظة:** النطاق المعتمد هو D-01 الى D-25.

## 6.1 تناقضات داخل الوثائق

| ID | المشكلة | العلاج | الحالة |
|---|---|---|---|
| D-01 | "15 قرارا" مقابل "العشرة" | توحيد الصياغة | RESOLVED |
| D-02 | حلقة دائرية في المرفقات | المرفقات = CONSTITUTION + المرحلة | RESOLVED |
| D-03 | Phase 00 تبني واجهات | Phase 00 = قرارات + هيكل فارغ | RESOLVED |
| D-04 | Hive boxes للمحتوى | Hive لبيانات المستخدم فقط | RESOLVED |
| D-05 | لا محتوى في DB | لا يكتب المحتوى الثابت في DB المستخدم | RESOLVED |
| D-21 | قالب بلا انحرافات | أضيف قسم Deviations | RESOLVED |

## 6.2 قرارات معمارية

| ID | المشكلة | العلاج |
|---|---|---|
| D-06 | Hive + drift = over-engineering | Hive فقط، drift في OD-0002 |
| D-07 | Quran JSON واحد | OD-0003 بقياس فعلي |
| D-08 | تطبيع البحث متأخر | OD-0004 قبل Phase 06 |
| D-22 | أرقام إصدارات من الذاكرة | تحقق من pub.dev |

## 6.3 المحتوى والتراخيص

| ID | المشكلة | العلاج |
|---|---|---|
| D-09 | Amiri vs Amiri Quran | توثيق الاسم الدقيق + OFL |
| D-10 | مصدر التلاوة | OD-0007 |
| D-19 | المراجع الشرعي غير محدد | content/reviewers.yaml |
| D-20 | تحقق بعدد السور فقط | عدد الآيات + checksum |
| D-25 | تراخيص pending | GeoNames APPROVED 2026-10-08 · PrayTimes APPROVED — FIXED |

## 6.4 مخاطر تقنية

| ID | المشكلة | العلاج |
|---|---|---|
| D-11 | الإشعارات عالية الخطر | Phase 00B Spike |
| D-12 | دقة المواقيت | حالات حدية + OD-0005 |
| D-13 | الوصولية في 27B فقط | بنود في كل مرحلة |
| D-14 | لا telemetry | سجل محلي (OD-0010) |
| D-15 | نقص منتج | OD-0006, OD-0009 |
| D-16 | لا آلية migrations | OD-0008 |
| D-17 | home widgets | OD-0017 |
| D-18 | لا تقدير جهد | أحجام S/M/L |
| D-23 | شبكة بلا تحقق | CI |
| D-24 | fatal-infos | CI |
| OD-0028 | Asr systematic shift −2/−3m across cities, −8m Tromsø | **CLOSED — accept-as-known-limitation (2026-10-09)** — no calculator defect (app == PrayTimes.js v2.5 golden, 0s × 12/12); offset is Aladhan-side (low-sun divergence ∝ zenith + unstable refs); reproducible Tromsø −4m within ±5m — `docs/od-0028-asr-investigation.md` |

## Phase 02 — Device Testing Bugs

> المصدر: `docs/phase-02-device-testing.md` — Rule 011 (Evidence Required).
> BUG-2 مسجَّل — **OPEN** (P2) — Option C approved 2026-10-09.

| ID | Bug | Severity | Found In | Status | Evidence |
|---|---|---|---|---|---|
| BUG-1 | `major_cities.json` — mojibake في `name_ar`/`country_ar` (double-UTF-8 عبر cp1256) | P1 | T2 — Oppo A95 (2026-10-09) | **FIXED in `c88cc97`** — verified | استبدال جراحي 234 قيمة؛ diff ‎234±234؛ checksum محدّث في `legal/assets.yaml` ‎(sha256:3eedc611…)؛ تحقق بصري: دبي/أبوظبي/لندن/ترومسو ✓ |
| BUG-3 | Cold-start deep link يتجاوز bootstrap في `/splash` → `selectCity` يرمي «Settings are unavailable before app initialization» (فشل صامت بلا تنقل) | P1 | T2 — Oppo A95 (2026-10-09) | **FIXED in `4ba60bd`** — analyze ✅ tests 256/256 | logcat `E flutter` 09:31:01 — `location_provider.dart:110` + `bootstrap_provider.dart:16`؛ **الإصلاح:** بوابة `bootstrapProvider` في `_AppBootstrap` (`lib/main.dart`) قبل بناء router — كل مسار (deep link / cold start / splash) ينتظر اكتمال bootstrap؛ شاشات loading وerror+retry بنفس ARB keys |
| BUG-4 | اختيار الإنجليزية في Onboarding لا يُطبَّق؛ `/prayer` يظل عربياً (تعذر الوصول لمسار LTR) | P1 | T8b — Oppo A95 (2026-10-09) | **FIXED in `cedbbac`** — analyze ✅ tests 257/257 | `docs/evidence/phase-02/t8-06-en-selected.png` مقابل `t8-07-empty-en-ltr.png`؛ **الإصلاح:** `MuslimGuideApp` تستهلك `appLocaleProvider` (ConsumerWidget) + `LanguageSelectionScreen` تحدّثها فور حفظها في Hive |
| BUG-2 | No UI path to change city after successful load | P2 | T7-02 — Oppo A95 (2026-10-09) | **FIXED in `fc2e479`** — device-verified 2026-10-09 (Step 0 PASS) | Registered 2026-10-09; Option C approved؛ **إثبات الجهاز:** `t-bug2-01..04` (4 صور) — زر `clickable=true` → picker → كابل: كل الصفوف أُعيد حسابها → settings `enabled=false`؛ logcat نظيف |
| BUG-5 | Splash deadlock — bootstrap gate (`4ba60bd`) causes splash to never navigate when bootstrap already complete (normal startup broken; only deep link works) | P0 | T0 — Oppo A95 (2026-10-09) | **FIXED in `862376e`** — analyze ✅ tests 262/262 | `t-bug2-00-fail-splash-deadlock.png` + logcat؛ regression test في `splash_screen_test.dart` |
| BUG-6 | Location picker opened via `context.go` from Prayer hero — no AppBar back button; system BACK exits app instead of returning to /prayer | P3 | M5 — Oppo A95 (2026-10-09) | **OPEN** (backlog — Phase 05+) | `t8c-03` observation + report M5 deviation #2 |

## Phase 04 — Device Testing Bugs

| ID | Bug | Severity | Found In | Status | Evidence |
|---|---|---|---|---|---|
| BUG-7 | Prayer notification arrives without audible sound although `prayer_adhan_v1` has a raw WAV sound configured | P1 | Oppo A95 / Android 13 — 2026-10-10 | **CLOSED (device-verified in `74a0700`)** — Device test 2026-10-11: 3 beeps heard + AudioTrack streamType 5 confirmed via logcat | Channel `prayer_adhan_v2` plays OGG correctly; WAV→OGG conversion confirmed as fix; evidence `docs/evidence/phase-04/p1-ogg-*.txt` |

## Phase 06 — Device Testing Bugs

| ID | Bug | Severity | Found In | Status | Evidence |
|---|---|---|---|---|---|
| BUG-8 | Swiping notification panel during Adhan playback stops `audio_service` on ColorOS. Diagnosis: not an `audio_session` interruption (H2 rejected), not `audio_service` pause/task-removed/notification-deleted hooks (H5 rejected). Suspected ColorOS media-session policy or Activity lifecycle; needs a controlled test on another device. | P2 | Phase 06 → Phase 07 | OPEN (deferred, device test pending) | Scenario 3, Abdo 2026-10-15 |

## Known Gaps (pre-Phase 03)

| ID | Gap | Severity | Found In | Status |
|---|---|---|---|---|
| GAP-meta-caret | `meta: ^1.15.0` يستخدم `^` بدل exact pin — Rule 019 audit | P3 | Pre-existing | **CLOSED (this commit — follows f44ffc9)** — Pinned to 1.18.3 exact (Rule 019). |
| GAP-license-page | لا يوجد `showLicensePage`/`LicenseRegistry` في `lib/` — سياسة `legal/02-attribution-policy.md` تتوقع عرض تراخيص الحزم (مثل flutter_timezone Apache-2.0) | P3 | CR-0010 review (2026-10-09) | **CLOSED-PARTIAL (Task 8)** — licenses entry in `/settings/notifications` opens `showLicensePage`; full attribution review stays Phase 05+ |
| GAP-compass-maintenance | flutter_compass 0.8.1 — maintenance stopped ~23 months; migration to sensors_plus if critical | P3 | CR-0011 (Phase 03) | **OPEN** (Phase 05+ audit) |
| GAP-hive-patch | hive_ce 2.20.1 → 2.20.2 patch upgrade | P3 | Phase 03 Task 2 | **CLOSED (this commit — follows f44ffc9)** |
| GAP-compass-pinned | flutter_compass 0.8.1 (MIT, exact) — added to pubspec | — | CR-0011 (Phase 03) | **CLOSED (this commit)** |
| GAP-city-resolution-dup | cityId → coordinates resolution duplicated in QiblaNotifier (copied from location_provider) | P3 | Phase 03 Task 6 | **OPEN (Phase 05+ refactor)** |
| GAP-qibla-bg | `assets/images/qibla_bg.webp` — license TBD — deferred | P3 | UI_VISION §4 (PROPOSED) | **OPEN** (Phase 05+ — UI polish؛ Phase 03 يستخدم gradient placeholder) |
| GAP-deeplink-consolidation | Deep-link intent filters path-specific (`/prayer`, `/qibla`); consider wildcard or production scheme | P3 | Phase 03 Task 10 | **CLOSED** — unified `muslimguide://<feature>/<action>` scheme and legacy aliases; unit/widget tests pass; verified on CPH2365 Android 13 (`docs/evidence/phase-04/t1-*.png`) |
| GAP-deeplink-host-loss | Flutter default deep linking passes path-only to GoRouter; host (`muslimguide://<feature>`) is lost. Path-only mapping in parser is workaround for Phase 04 (test-only usage). If deep links become UI-facing or actions collide, migrate to Solution B (MethodChannel with full URI + `flutter_deeplinking_enabled=false`). | P3 | Phase 04 | OPEN (Phase 05+) |
| GAP-notif-adhan-pinned | `flutter_local_notifications` 22.3.1 + `timezone` 0.11.1 + `just_audio` 0.10.6 + `audio_service` 0.18.19 (exact) — added to pubspec | — | CR-0012 (Phase 04) | **CLOSED** (`a331b78`) |
| GAP-notification-permission-diagnostics | Notification permission and exact-alarm status flow with diagnostics screen | — | Phase 04 Task 3 | **CLOSED** (implementation, automated tests, and Oppo A95 device flow complete) |
| GAP-methodchannel-sdkint | Custom MethodChannel to read Build.VERSION.SDK_INT — consider device_info_plus package in Phase 05+ | P3 | Phase 04 Task 3 | OPEN (Phase 05+) |
| GAP-device-task3 | Diagnostics screen device tests deferred — bundle with Task 4 device session | P3 | Phase 04 Task 3 | CLOSED (Oppo A95 / Android 13, 2026-10-10) |
| GAP-boot-no-recalc | Plugin boot receiver did not restore scheduled alarms after device reboot until app launch, risking missed notifications | P2 | Phase 04 Task 4 — Oppo A95 / Android 13 (2026-10-10) | CONFIRMED (0 → 0 → 33 after app launch; `docs/phase-04-device-testing.md`; Phase 05+ consider native WorkManager/AlarmManager) |
| GAP-prayer-notification-timing | Prayer notification delivered 76.526s after scheduled alarm on Oppo A95 / ColorOS 13, beyond the ±60s target; AlarmManager dump showed a 725,776ms delivery window despite exactAllowWhileIdle request | P1 | Phase 04 Task 4 — Oppo A95 / Android 13 (2026-10-10) | CONFIRMED — scheduler/OEM timing investigation required before Task 6 |
| GAP-t4-timing-margin | Foreground exact-alarm timing: +44.888s (within ±60s target). Higher than expected for foreground setExact — investigate in Phase 05+ | P3 | Phase 04 Task 4 | OPEN |
| GAP-adhan-truncation | Android may truncate notification sound >30s — verify on Oppo A95 + document | P3 | Phase 04 Task 5 | OPEN (device test) |
| GAP-audio-service-coloros | audio_service background play may be blocked on ColorOS 13 without battery optimization disabled | P3 | Phase 04 Task 5 | PARTIAL (Oppo A95 swipe-away/reopen passed with Don't optimize and background running enabled; behavior with optimization enabled remains unverified) |
| GAP-format-time-dup | `_formatTime` duplicated in night_thirds_row — shared util `formatTimeHm` in `lib/shared/utils/time_format.dart` (Phase 05-A: util + 4 unit tests) | P3 | Phase 04 CR-0013 | **CLOSED** |
| GAP-night-thirds-2x-calc | nightThirdsProvider re-calculates 2x per refresh (today + tomorrow) — acceptable; revisit if perf issue | P3 | Phase 04 CR-0013 | OPEN |
| GAP-system-silence-not-detectable | System-level silence (silent mode/DND on `usage: media` audio) generates no interruption event and is not detectable via `audio_session`; no custom MethodChannel used | P3 | Phase 04 Task 6 | OPEN (documented limit) |
| GAP-cr0013-missing-photo | CR-0013 device-verified PASS by owner, screenshot added | P3 | Phase 04 CR-0013 | **CLOSED** (screenshot `docs/evidence/phase-04/cr0013-01-prayer-with-thirds.png`) |
| GAP-task6-device-interruption | Audio focus interruption (real call, competing session, system silence) not device-tested — requires physical call. Schedule next device session | P2 | Phase 04 Task 6 | OPEN |
| GAP-all-prayers-disabled-hint | Subtle all-off hint under prayer switches in `/settings/notifications` (Phase 05-A: hint widget + ARB + 2 widget tests) | P3 | Phase 04 Task 7 | **CLOSED** |
| GAP-integration-player-race | Integration adhan_player_test race: state stream may miss 'playing' on short assets / ColorOS. Test redesigned to observe sequence (subscribe-before-play, any-non-idle, back-to-idle). If still unstable → GAP-integration-player-coloros. | P3 | Phase 04 Task 10 | OPEN |
| GAP-calc-method-ui | No UI to select calculation method (MWL default). Egyptian users see +7 min Fajr offset. Phase 05-B: UI + country detection. | P2 | Phase 05-A → 05-B | OPEN |
| GAP-widget-test-layout-coupling | notifications_settings_screen_test couples to absolute layout (viewport assumptions broke 3 tests when the calc section was added; mega-test CI-fragile — scrollUntilVisible(delta) depends on viewport + font metrics, confirmed on CI after c188955: Windows local PASS, Linux CI FAIL). Split into section-specific tests. Prefer section-specific tests. Refactor remaining in Phase 06. | P2 | Phase 05-A | OPEN |
| GAP-atomic-commit-gap | Atomic commit (b847a1a) missed a staged test file — CI-012 caught it (583 < 584). `git add <explicit list>` is vulnerable to oversights. Rule: full `git status` review + WIP diff scan BEFORE commit; or `git add <dir>/` for touched trees. | P3 | Phase 05-B | OPEN |
| GAP-in-call-adhan-fallback | During active call: Android audio focus blocks audio_service adhan; notification "ding" + prayer text fallback. Expected behavior (platform). Full adhan works when app closed + no call (2:34 confirmed). Consider "listen after call" prompt (Phase 06). | P3 | Phase 05-B | DOCUMENTED |
| GAP-multi-adhan-deferred | Multi-Adhan (CR-0015) DEFERRED indefinitely pending verified license. Beautiful_adhan.ogg (CC0) is sole source. Rejected: Meccah 2013 (YouTube compression), archive.org (no license). Owner may pursue: (a) local mosque recording, (b) SBA Saudi TV license, (c) institutional CC0 source. Re-open as CR-0016 when source verified. | P3 | Phase 05-C → Phase 06+ | OPEN (deferred) |
| GAP-azkar-pack-pending | Azkar pack: no verified license source. Checked: itsyaasir/hisn-al-muslim (GPL code + UNKNOWN content — BLOCKED), rn0x/hisn_almuslim_json (no LICENSE — BLOCKED), IslamHouse-API (MIT code, content usage policy allows download/publish/offline with source citation but no adhkar JSON pack found — owner decision pending), sunnah.com/hisn (403 — UNKNOWN). Production ships NO pack: loader returns null when `assets/data/azkar_pack.json` is absent/invalid/placeholder-shaped; UI shows pending-pack Empty state ("Azkar library is being prepared"). Sample JSON lives only in `test/fixtures/azkar_pack_sample.json` (CI-017 compliant). Real text = single commit dropping the verified file when owner approves. If all sources rejected → defer Phase 06 content to Phase 07+. | P1 | Phase 06 | OPEN (blocks content) |
| GAP-azkar-pdf-scanned | Submitted azkar PDF is scanned and not text-searchable; cannot reliably identify text duplicates or verify hadith grades from it. Obtain a UTF-8 text export from the original Word document before resuming duplicate and grade verification. | P2 | Phase 07 | OPEN |
| GAP-ci017-policy-exemption | `legal/policy.yaml` echoes the `ci_017_placeholder` exemption list but `tool/check_no_placeholder.sh` never honors it (scans all of `lib/` + `assets/` unconditionally). Fix in Phase 07 (out of Phase 06 scope; no legal/CI edits per Director). | P3 | Phase 06 | OPEN |
| GAP-const-new-mandate-conflict | Dart 3.13 `const new(...)` mandate (phases/02.md) conflicts with lint `unnecessary_type_name_in_constructor` (+ `unnecessary_const_in_enum_constructor` on value enums). 3 ignore directives with documented reasons (CI-014 compliant): `azkar_category.dart:22`, `azkar_pack.dart:13`, `azkar_test_helpers.dart:25`. Consider codebase-wide CR for unified resolution. | P3 | Phase 06 | OPEN |
| GAP-ci018-posix-regex | `check_no_print.sh` used `\s` inside `[...]` (not POSIX whitespace). Git Bash + some grep variants fail. Fixed with `[[:space:]]`. | P3 | Phase 06 | CLOSED (b79e3c9) |
