# Approved Decisions

## DEC-0001 — Framework
- **Status**: APPROVED
- **Title**: Flutter + Dart
- **Decision**: استخدام Flutter مع إصدار Dart مثبت عبر FVM.
- **Reason**: توحيد المنصات، سرعة التطوير، دعم RTL/LTR ممتاز.
- **Consequences**: التزام بـ Flutter SDK مثبت في CI.
- **Affected Documents**: `architecture/02`, `ci/00`
- **Supersedes**: —

## DEC-0002 — State Management
- **Status**: APPROVED
- **Title**: Riverpod
- **Decision**: استخدام Riverpod (الإصدار يُحسم في OD-0018).
- **Reason**: AsyncNotifier مناسب للبيانات، اختبار سهل، `autoDispose` افتراضي.
- **Consequences**: ممنوع `provider` أو `get_it` بلا CR.
- **Affected Documents**: `architecture/04`

## DEC-0003 — Navigation
- **Status**: APPROVED
- **Title**: go_router
- **Decision**: استخدام `go_router` مع مسارات feature-first.
- **Affected Documents**: `architecture/05`

## DEC-0004 — User Data Storage
- **Status**: APPROVED
- **Title**: Hive CE
- **Decision**: Hive CE لبيانات المستخدم فقط. ممنوع تخزين المحتوى الديني فيه.
- **Affected Documents**: `architecture/03`

## DEC-0005 — Static Content
- **Status**: APPROVED
- **Title**: Assets للقراءة فقط
- **Decision**: المحتوى الثابت (قرآن، أذكار، …) في `assets/` للقراءة فقط.
- **Affected Documents**: `architecture/03`, `content/`

## DEC-0006 — Localization
- **Status**: APPROVED
- **Title**: AR + EN مع اختيار عند التنصيب
- **Decision**: دعم اللغتين، مع شاشة اختيار عند أول تشغيل.
- **Affected Documents**: `product/06-onboarding.md`, `architecture/07-localization.md`

## DEC-0007 — Theme
- **Status**: APPROVED
- **Title**: Material 3 + Light/Dark/System
- **Decision**: استخدام M3 مع design tokens.
- **Affected Documents**: `product/04-settings.md`

## DEC-0008 — Audio Stack
- **Status**: APPROVED
- **Title**: audio_service + just_audio
- **Decision**: لـ Phase 07 فقط.
- **Affected Documents**: `phases/07`, `content/06`

## DEC-0009 — Notifications
- **Status**: APPROVED
- **Title**: flutter_local_notifications + timezone
- **Decision**: مع اختبار Spike في Phase 00B.
- **Affected Documents**: `phases/00b`, `phases/04`

## DEC-0010 — Testing
- **Status**: APPROVED
- **Title**: flutter_test + mocktail + integration_test
- **Decision**: golden اختياري.
- **Affected Documents**: `quality/01`

## DEC-0011 — Quality Gates
- **Status**: APPROVED
- **Title**: `flutter analyze --fatal-infos` + very_good_analysis
- **Decision**: لا warnings، لا infos، لا `// ignore` غير موثق.
- **Affected Documents**: `quality/02`, `ci/01`

## DEC-0012 — Privacy
- **Status**: APPROVED
- **Title**: لا telemetry
- **Decision**: لا إرسال بيانات، لا crash reporting خارجي في v1.
- **Affected Documents**: `security/03`

## DEC-0013 — Content Review
- **Status**: APPROVED
- **Title**: مراجعة شرعية عبر HTML + JSON
- **Decision**: كل pack يمر بمسار مراجعة موثق، والاعتماد مكتوب.
- **Affected Documents**: `content/08-review-workflow.md`, `content/reviewers.yaml`

## DEC-0014 — Code License
- **Status**: APPROVED
- **Title**: MIT License للكود
- **Decision**: ترخيص كود التطبيق `MIT`.
- **Reason**: توافق مع OFL/CC-BY/QuranEnc، بساطة، لا تعارض مع مكتبات Flutter.
- **Decided**: 2026-10-05 (حسم OD-0001)
- **Affected Documents**: `LICENSES.md`, `phases/00-foundation.md`, `governance/cr/`

## DEC-0015 — Platforms (v1.0)
- **Status**: APPROVED
- **Title**: Android فقط في v1.0
- **Decision**: Android فقط في v1.0 — `minSdk 24`، `compileSdk 36`، `targetSdk 34`.
- **Note**: Flutter 3.47.5 enforces minSdk 24.
- **Amended**: CR-0003 (2026-10-06) — كان `minSdk 23`؛ CR-0007 (2026-10-06) — كان `compileSdk 35`.
- **Consequences**: iOS مؤجل إلى v2.0+ وسُجّل كـ OD-0021.
- **Decided**: 2026-10-05 (حسم OD-0006)
- **Affected Documents**: `pubspec.yaml`, `android/`, `phases/00-foundation.md`

## DEC-0016 — Riverpod Version
- **Status**: APPROVED
- **Title**: flutter_riverpod 2.6.1 (آخر إصدار 2.x ثابت)
- **Decision**: تثبيت `flutter_riverpod: 2.6.1` تثبيتًا صريحًا (بلا `^`).
- **Verification**: pub.dev، تاريخ التحقق 2026-10-05، تاريخ النشر 2024-10-22، الترخيص MIT — https://pub.dev/packages/flutter_riverpod/versions/2.6.1
- **Decided**: 2026-10-05 (حسم OD-0018)
- **Affected Documents**: `pubspec.yaml`, `LICENSES.md`, `security/02-dependencies.md`

## DEC-0017 — Reference Device
- **Status**: APPROVED
- **Title**: Pixel 6a (أساسي) + Redmi Note 12 (ثانوي)
- **Decision**: Pixel 6a الجهاز المرجعي الأساسي، Redmi Note 12 ثانوي.
- **Decided**: 2026-10-05 (حسم OD-0019 — أغلق GAP-009)
- **Affected Documents**: `phases/00-foundation.md`, `quality/`

## DEC-0018 — Phase-Aware CI Rollout
- **Status**: APPROVED
- **Title**: تفعيل فحوصات CI مرحليًا
- **Decision**:
  - **Phase 00:** CI-009 (analyze), CI-010 (test), CI-011 (build-debug), CI-002 (asset scan أساسي), CI-018 (Flutter version pinned).
  - **Phase 00B → Phase 04:** إضافة CI-012 … CI-017.
  - **Phase 05+:** إضافة CI-001, CI-003 … CI-008 (license gate كامل) — مشروطًا بتحديث `legal/assets.yaml` إلى schema v2 أولًا.
- **Reason**: License Gate يفترض محتوى مُشحونًا؛ `legal/assets.yaml` ما زالت بصيغة schema v1 ومخالفة لـ S-001/S-003.
- **Decided**: 2026-10-05 — `governance/cr/CR-0001-phase-aware-ci-rollout.md`
- **Affected Documents**: `ci/00-ci-policy.md`, `ci/01-ci-checks.md`, `phases/00-foundation.md`, `.github/workflows/ci.yml`

## DEC-0023 — Notification receivers manual addition
- **Status**: APPROVED
- **Date**: 2026-10-06
- **Decision**: Declare `ScheduledNotificationReceiver` and `ScheduledNotificationBootReceiver` explicitly in the Android Manifest for `flutter_local_notifications` 22.3.1.
- **Reason**: In the Phase 00B build, `flutter_local_notifications` 22.x did not add either receiver to the merged manifest. The missing declarations were confirmed in the built manifest; scheduling was accepted but notifications were not delivered until the receivers were added manually.
- **Consequences**:
  - Phase 04 must include the required receiver declarations in the main app Manifest.
  - Document the integration in `phases/04` and related documentation.
  - Verify the merged manifest after any `flutter_local_notifications` upgrade.
- **Evidence**: `spike/RESULTS.md` — Step 5 final results, plus `spike/evidence/merged_manifest_with_receivers.xml`.

## DEC-0024 — User data migrations
- **Status**: APPROVED
- **Date**: 2026-10-06
- **Decision**:
  - Add an integer `schemaVersion` to each Hive box.
  - Implement migrations manually, without a migration library.
  - Test migrations from every prior production version, starting with v1.
- **Reason**: Simple, dependency-free, and sufficient for the requirements.

## DEC-0025 — Local error log
- **Status**: APPROVED
- **Date**: 2026-10-06
- **Decision**:
  - Store JSON Lines at `{app_documents}/logs/errors.jsonl`.
  - Record `timestamp`, `level`, `message`, optional `stack`, and `context`.
  - Rotate at 1 MB, retaining the latest 1,000 events.
  - Export manually through the system share sheet.
  - Do not record personal information.
- **Reason**: JSONL is simple, machine-readable, and requires no additional library.

## DEC-0026 — Numerals
- **Status**: APPROVED
- **Date**: 2026-10-06
- **Decision**:
  - Use Latin numerals (0-9) in interface values such as times, counters, and settings.
  - Preserve Arabic-Indic numerals (٠-٩) in Quranic text.
  - Use `intl` `NumberFormat` according to locale where localized formatting is needed.
- **Reason**: Latin numerals are universal for interface values and simplify bidirectional layout; Quranic text retains its source convention.

## DEC-0027 — Hive encryption
- **Status**: APPROVED
- **Date**: 2026-10-06
- **Decision**:
  - Do not encrypt Hive data in v1.
  - Stored data is limited to settings, onboarding state, and last-read position; it does not include sensitive personal information.
  - Revisit encryption through a new open decision if requirements change; `flutter_secure_storage` may then be evaluated for key storage.
- **Reason**: The current stored data is not sensitive, and encryption can be added later if needed.

## DEC-0028 — Prayer calculation method

**Status:** APPROVED
**Date:** 2026-10-07

**Decision:**
- **Default calculation method:** Muslim World League (MWL).
- **User options:** MWL, Egyptian, Umm al-Qura, Karachi, ISNA, Tehran, Jafari.
- **Default Asr method:** Standard (Shafi'i/Maliki/Hanbali).
- **Alternative Asr method:** Hanafi.
- **Default high-latitude rule:** MiddleOfNight.
- **High-latitude options:** MiddleOfNight, SeventhOfNight, TwilightAngle, None.

**Reason:** MWL is broadly used internationally; the available options cover the principal calculation conventions.

**Consequences:**
- Persist the selected method and related settings in `SettingsRepository`.
- Expose the options in `PrayerTimesScreen` and `SettingsScreen`.
- The domain calculator accepts a `CalculationMethod` parameter.

## DEC-0029 — Automatic timezone detection

**Status:** APPROVED
**Date:** 2026-10-07

**Decision:**
- Use `flutter_timezone` to read the device's timezone.
- Replace the temporary Phase 01 `Asia/Riyadh` timezone.
- On detection failure, fall back to `Asia/Riyadh` and write a warning to the local log.

**Reason:** `flutter_timezone` reads the system timezone; `DateTime.now().timeZoneName` may return ambiguous or platform-dependent abbreviations.

**Consequences:**
- Approve CR-0010 for `flutter_timezone`, including pub.dev verification, license review, and an exact version pin, before adding the dependency.
- Update `bootstrap_provider.dart` to resolve the system timezone and set the timezone database's local location.

**Package:** `flutter_timezone` — verify on pub.dev before CR-0010 approval and implementation.

## DEC-0030 — Quran storage format: JSON

**Status:** APPROVED
**Date:** 2026-10-16

**Decision:** Store the Quran text as JSON at `assets/content/quran/quran-uthmani.json`.

**Reason:**
- The generated dataset is 1.77 MB, acceptable for a bundled asset.
- It can be loaded directly from Flutter assets without SQLite or another package.
- The reader can select surahs from the structured JSON.
- Cold-start performance remains subject to measurement against REQ-QURAN-001 on the reference device.

**Alternatives considered:**
- SQLite asset: unnecessary infrastructure for this dataset.
- Compressed JSON: additional complexity without a demonstrated need.

**Closes:** OD-0003.

## Change Requests (CRs)

- CR-0001 — Phase-Aware CI Rollout — APPROVED (2026-10-05) — `governance/cr/CR-0001-phase-aware-ci-rollout.md`
- CR-0002 — توحيد تسمية Phase A → Phase 00 — APPROVED (2026-10-05) — `governance/cr/CR-0002-phase-a-naming.md`
- CR-0003 — minSdk 24 — APPROVED (2026-10-06) — `governance/cr/CR-0003-minsdk-24.md`
- CR-0004 — audio_service + just_audio داخل spike — APPROVED (2026-10-06) — `governance/cr/CR-0004-audio-in-spike.md`
- CR-0005 — توسيع عقد أسماء jobs في CI — APPROVED (2026-10-06) — `governance/cr/CR-0005-ci-job-names-expanded.md`
- CR-0006 — path_provider في التطبيق الرئيسي — APPROVED (2026-10-06) — `governance/cr/CR-0006-path-provider-main-app.md`
- CR-0007 — compileSdk 36 لدعم share_plus — APPROVED (2026-10-06) — `governance/cr/CR-0007-compilesdk-36-share-plus.md`
- CR-0008 — timezone package — APPROVED (2026-10-07) — `governance/cr/CR-0008-timezone-package.md`
- CR-0009 — geolocator package — APPROVED (2026-10-08) — `governance/cr/CR-0009-geolocator.md`
### DEC-0033 — Hijri calendar calculation

**Status:** APPROVED
**Date:** 2026-10-17

**Decision:**
- حساب هجري عبر `hijri 3.0.1` (Umm al-Qura مضمّن).
- تعديل مستخدم ±1 يوم (يُحفظ في Hive settings).
- Offline كامل (صفر dependencies، بلا شبكة).

**Reason:**
- لا جدول أم القرى PD متاح (الموقع الرسمي بلا تحميل؛ البديل 404).
- `hijri` package = الخيار التقني الأفضل (يدّعي Umm al-Qura + تعديل أصيل).
- ±1 يطابق REQ-HIJRI-001.
- Offline-first (حساب محلي).

**Alternatives Considered:**
- جدول أم القرى PD مستقل: غير متاح.
- حساب فلكي/جدولي يدوي (~30 سطراً): مرفوض — ليس أم القرى.
- `flutter_hijri_date_picker`: مرفوض — حزمة UI إضافية غير ضرورية.

**Consequences:**
- `hijri 3.0.1` مثبتة (BSD-2-Clause) — CR-0019.
- 5 تواريخ مرجعية تُختبر ضد ummulqura.org.sa (يزوّدها المالك).
- التوسعة لـ±2 ممكنة لاحقاً (بقرار موثق).

**Closes:** OD-0005

### DEC-0031 — Phase A definition

**Status:** APPROVED
**Date:** 2026-10-16

**Decision:** phase_A = ["00", "00B"] (بنية تحتية).

**Reason:**
- 00 = قرارات + وثائق + CI
- 00B = Spike الإشعارات
- كلاهما مكتمل

**Consequences:**
- APR-0001 APPROVED
- يفتح Phase 01 (جزء من phase_B)

### DEC-0032 — Phase B approved (retroactive)

**Status:** APPROVED
**Date:** 2026-10-16

**Decision:** phase_B = ["01"..."09"] APPROVED بأثر رجعي.

**Reason:**
- 01-04 مكتملة
- 05 skeleton مكتمل
- 06 جاري
- الاعتماد متأخر إدارياً

**Consequences:**
- APR-0002 APPROVED
- العمل مستمر
- CR-0016: annotated tags