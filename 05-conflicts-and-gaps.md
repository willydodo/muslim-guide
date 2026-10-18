# Conflicts and Gaps

## Conflicts

### CON-001 — ترقيم القرارات المفتوحة
- **Documents**: `MASTER_ROADMAP v3.0 §4.2` ↔ `04-open-decisions.md`
- **Statement A**: `OD-01 … OD-17`
- **Statement B**: `OD-0001 … OD-0020`
- **Resolution**: تم توحيد الترقيم على `OD-0001` وأُعيد تصنيف القرارات.
- **Status**: RESOLVED

### CON-002 — سجل المحتوى
- **Documents**: `CONTENT_REGISTRY` ↔ `legal/assets.yaml`
- **Resolution**: `legal/assets.yaml` هو المصدر الرسمي. `content/` يشرح الأنواع.
- **Status**: RESOLVED

### CON-003 — Riverpod
- **Documents**: `v3.0 §4.1` ↔ `architecture/04`
- **Resolution**: Riverpod محسوم كإطار (DEC-0002)، الإصدار في OD-0018.
- **Status**: RESOLVED

### CON-004 — قالب المرحلة
- **Documents**: `v3.0 §12.3` ↔ `Master Spec §51`
- **Resolution**: القالب الموحد في `phases/_template.md` يشمل: Deviations، Command Output، Human Review.
- **Status**: RESOLVED

### CON-005 — تقرير المخرجات
- **Resolution**: أُنشئ `governance/05-output-report-template.md`.
- **Status**: RESOLVED

## Gaps

### GAP-001 — سجل المراجعين الشرعيين
- **Resolution**: `content/reviewers.yaml`
- **Status**: RESOLVED

### GAP-002 — مسار HTML+JSON للمراجعة
- **Resolution**: `content/08-review-workflow.md`
- **Status**: RESOLVED

### GAP-003 — قائمة المصادر الفعلية
- **Resolution**: `legal/assets.yaml` + `content/00-content-policy.md`
- **Status**: RESOLVED

### GAP-004 — شاشة اختيار اللغة
- **Resolution**: `product/06-onboarding.md`
- **Status**: RESOLVED

### GAP-005 — قرار l10n
- **Resolution**: `architecture/07-localization.md`
- **Status**: RESOLVED

### GAP-006 — قالب المرحلة الموحد
- **Resolution**: `phases/_template.md`
- **Status**: RESOLVED

### GAP-007 — جدول المراحل
- **Resolution**: `phases/README.md`
- **Status**: RESOLVED

### GAP-008 — قواعد التوقف
- **Resolution**: `governance/01-ai-development-rules.md`
- **Status**: RESOLVED

### GAP-009 — الجهاز المرجعي
- **Resolution**: حُسم بـ DEC-0017 (Pixel 6a أساسي، Redmi Note 12 ثانوي)
- **Status**: RESOLVED

### GAP-azkar-core-v2-converter — core_v2 schema needs converter to AzkarPack
- **Finding**: review-schema packs (`pack_id`/`version`/`checksum`/`approval` + per-item `review`) do not match the domain model (`categories`/`items` with `text`/`virtue`/`repeat`/`source`).
- **Resolution**: temporary bridge `lib/features/azkar/data/azkar_pack_loader_v2.dart` (`CoreV2PackConverter`) + unit test `test/features/azkar/core_v2_converter_test.dart`. It maps `virtue` to `—` (no source data) and ignores `repeat_by_prayer`/`repeat_note` (no domain field yet); review gating stays with the caller.
- **Priority**: P3 | **Phase**: 07 | **Status**: OPEN

### GAP-tasbih-6-entries — Phase 05c Tasbih pack PENDING_REVIEW
- **Finding**: 6 entries from HadeethEnc (verbatim, all صحيح): 6259 (33/33/34),
  5516 (100x), 65905 (100x tahlil), 4809 (100x tawba).
- **E-1 removal (2026-10-18)**: hawqala (Bukhari 6384) not in HadeethEnc;
  5477 (baqiyat) is not a match — removed per Rule 020. 6 entries only.
- **Limitation**: E-1 sunnah.com cross-check blocked (HTTP 403) — recorded,
  manual check by Abdo/shaykh-1 pending.
- **Review artifacts (2026-10-18)**: `content/reviews/tasbih-v1-review-2026-10-18.html`
  + `.json` — sent to shaykh-1, awaiting decisions.
- **APPROVED (2026-10-18)**: shaykh-1 approved all 6 (no edits, no notes).
  Decisions: `content/reviews/decisions-tasbih-v1-2026-10-18.json`.
  Checksum rotated content-only: `sha256:339136d2…` (old `6cca0748…` was
  computed before the review merge script existed — see deviation note in
  `58ef3b8` report; pack content itself unchanged, checksum matches
  decisions file).
- **Priority**: P3 | **Phase**: 05c | **Status**: CLOSED (APPROVED, production)

### GAP-azkar-core-v2-part2 — Phase 07 part 2 (237 entries) PENDING_REVIEW
- **Finding**: 13 packs built from Abdo's verified part-2 file (237 blocks):
  wake_sleep 25, home 3, mosque 13, prayer 54, distress 11, fear 8,
  satan 14, repentance 7, illness 9, funeral 15, newborn 6, food 13,
  misc 59. Grades: 213 صحيح + 19 حسن + 5 review_required (kept in JSON,
  filtered in UI per Q2). degree_raw held literally + grade_simple derived.
- **Needs**: shaykh-1 review (scope expanded 2026-10-18).
- **Priority**: P3 | **Phase**: 07 | **Status**: OPEN

### GAP-deeplink-coldstart — adb deep links do not reach go_router
- **Finding (2026-10-18, device test partial PASS)**: `/tasbih` → Home (splash
  forces `/home` before any pending deep link settles); `/tasbih/subhanallah`
  → "Page not found". Root causes: (1) no `app_links`/`uni_links` listener in
  `lib/` — no `getInitialLink`/`uriLinkStream` wiring, so cold-start intents
  never reach `DeepLinkParser`; (2) `SplashScreen` calls `context.go('/home')`
  unconditionally after bootstrap, crushing any in-flight deep link.
- **In-app navigation works** (`/tasbih`, `/tasbih/:id`, parser mappings all
  verified read-only). Only the adb/external path is broken.
- **Fix (deferred)**: add `app_links` package (needs CR + license check) +
  pending-deep-link hold in splash before `go('/home')`.
- **Priority**: P3 | **Phase**: 05c → Phase 09+ | **Status**: OPEN

### GAP-azkar-expansion-deferred — Full Azkar/Adiya expansion deferred
- **Finding**: `الأذكار.docx` contains 304 entries (not 382 — Director estimate corrected, no second file).
- **Reasons**: (1) dorar.net/sunnah.com blocked (HTTP 403 — no automated verification possible);
  (2) `dorar_hadith` package requires drift (blocked by OD-0002 until Phase 12);
  (3) external verification duplicates degrees already present in the file itself.
- **Decision**: v1.0 = 7 approved morning adhkar only (`morning.json`, PARTIALLY_APPROVED).
- **Priority**: P2 | **Phase**: 07 (frozen) | **Status**: OPEN (deferred to Phase 09+)
- **Date**: 2026-10-17
