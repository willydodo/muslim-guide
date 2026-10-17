## Phase 00B — ✅ COMPLETED (2026-10-06)

**Summary:**
- Steps 1-5 ✅
- 6/6 core tests passed on CPH2365 / Android 13 / API 33.
- Human audio verification: ✅ user confirmed the Beep was audible.
- Remaining deferrals to Phase 04: Audio Focus (OD-0023) and long-term OEM behavior (OD-0024).
- Duration: 1 day.

**Key lessons:**
1. Notification receivers must be declared manually for the tested plugin setup (DEC-0023).
2. ColorOS/Oppo may require battery optimization, background-running, and auto-launch settings.
3. Hive access across isolates uses an `IsolateNameServer` + `SendPort` bridge.

**Phase 01 preparation decisions:** OD-0008, OD-0010, OD-0012, and OD-0013 are decided by DEC-0024 through DEC-0027.

# Phase Progress — Snapshot

> Updated 2026-10-16. Canonical phase numbering follows `phases/README.md`.

| Phase | Scope | Status |
|---|---|---|
| 01–04 | Foundation, prayer/location, Qibla, Adhan/notifications | Completed |
| 05 | Azkar skeleton and pending-pack Empty state | Completed; content pack deferred beyond v1.0 |
| 05b | Azkar Pack (HadeethEnc pilot) | Review merged 2026-10-17 — PARTIALLY_APPROVED (7/9), gaps in docs/azkar-gaps.md |
| 06 | Quran | Completed |
| 07 | Recitation | Deferred to v1.5 (CR-0018) |
| 08 | Calendar (Hijri) | Completed 2026-10-17 |
| 09 | v1.0 stabilization | Upcoming (after 05b) |

## Phase 05b (Azkar Pack) — Pilot ✅ (2026-10-17)

- Source: HadeethEnc.com (NoDerivs + Attribution) — CR-0020.
- Pilot: `assets/content/azkar/core/morning.json` — category 301, 9 hadeeths (7 صحيح + 2 حسن).
- Review merged (`0b4d790`): PARTIALLY_APPROVED — 7 approved (incl. 2 with rejected edits, dual-saved) + 2 rejected (no reason).
- Gaps: `docs/azkar-gaps.md`. No full APPROVED. No expansion, no Flutter code before your explicit approval.

## Phase 08 (Hijri Calendar) — ✅ (2026-10-17)

## Phase 06 — Quran (ACTIVE)
- `assets/content/quran/` and `lib/features/quran/` contain placeholders only; no Quran dataset or feature implementation is present.
- Next: verify source terms and attribution requirements before obtaining Quran text, then record provenance and validate the data before implementation.
- No Quran code or content is represented as completed.

## Phase 05 — Azkar
- Skeleton and pending-pack Empty state are complete.
- The received content remains unverified and is not shipped; the rights-clean rebuild is deferred beyond v1.0.
- Output report: `docs/azkar-skeleton-output-report.md`.

## Historical progress records
Older phase-specific task labels below this snapshot are preserved as historical records. Use the phase mapping above and `phases/README.md` for current numbering.

---



\## المرحلة الحالية



\*\*Phase 01 — Foundation (2026-10-07)\*\*
| البند | القيمة |
|---|---|
| Status | 🟢 ACTIVE |
| Started | 2026-10-06 |
| Data layer | ✅ (Session 10) |
| UI foundation | ✅ l10n + theme + go_router (Session 11) |
| Bootstrap | ✅ timezone + Hive + error log (Session 12) |
| UI screens | ✅ Splash + Language + Router + main (Session 13) |
| Status | ~85% — يتبقى Welcome Shell (اختياري) + integration tests |
| Last Phase 01 commit | `e5e2f9c` |
| Validation | `flutter analyze --fatal-infos`: بلا مشاكل؛ `flutter test`: 7/7؛ `flutter build apk --debug`: نجح |

## Phase 02 — Prayer Times & Location
- **Status:** ✅ COMPLETED (2026-10-09)
- **Duration:** 3 days (2026-10-07 → 2026-10-09)
- **Tests:** 262/262
- **Bugs:** 1, 2, 3, 4, 5 ✅ FIXED
- **Output Report:** docs/phase-02-output-report.md

## Phase 03 — Qibla
- **Status:** ✅ COMPLETED (2026-10-10)
- **Duration:** 1 day (2026-10-09 → 2026-10-10)
- **Tests:** 368/368
- **Bugs/fixes:** BUG-5 (Phase 02 regression) + Task 9.5 no-magnetometer fix
- **Output Report:** docs/phase-03-output-report.md

## Phase 00B — سجل الإغلاق

\*\*Phase 00B — Spike: الإشعارات والصوت\*\*



| البند | القيمة |

|---|---|

| Status | ✅ COMPLETED (with deferred items) |

| Started | 2026-10-06 |

| Current Step | 6 / 6 ✅ — Step 5 device testing and closeout complete |
| Blockers | لا يوجد لإغلاق 00B؛ Audio Focus (OD-0023) وlong-term OEM (OD-0024) مؤجلان إلى Phase 04 |
| Exit Criteria | اختبار جهاز حقيقي CPH2365 / Android 13 + جدول نتائج |



\### الخطوات الست



| # | الخطوة | الحالة |

|---|---|---|

| 1 | إنشاء `spike/` كامل | ✅ |

| 2 | CR-0004 + تحديث phases | ✅ |

| 3 | CI jobs (CI-012/014/015/016/017) | ✅ PR #2 — 9/9 success |

| 4 | بناء Spike كامل | ✅ |

| 5 | اختبار وظيفي (جهاز فقط) | ✅ مكتمل — foreground/background/reboot/permissions/Hive |
| 6 | توثيق النتائج + إغلاق 00B | ✅ مكتمل — 2026-10-06 |

## Remaining Deferrals
- Audio Focus أثناء مكالمة حقيقية: OD-0023 (Phase 04).
- سلوك OEM طويل المدى: OD-0024 (Phase 04).
- اكتمل التأكيد السمعي البشري للصوت: ✅ المستخدم أكد سماعه في 2026-10-06؛ موثق في `spike/RESULTS.md`.
- **GAP-compass-maintenance (P3)** — audit/migration review in Phase 05+.
- **GAP-city-resolution-dup (P3)** — Phase 05+ refactor.
- **GAP-license-page (P3)** — Phase 05+.
- **GAP-deeplink-consolidation (P3)** — Phase 04+.
- **GAP-qibla-bg (P3)** — Phase 05+ UI polish.
- **BUG-6 picker back nav — Phase 05+ (P3)** — لا AppBar back + BACK يخرج التطبيق.
- **Permission-deny-only path — Phase 05+ (P3)** — (Location ON + Deny فقط) غير مُختبَر.
- **Minor-1 overflow @ 200% — Phase 10 (P3)**.
- **flutter_timezone (DEC-0029) غير مُضاف** — `tz.local` ثابت Asia/Riyadh (`bootstrap_provider:36` TODO مُعلن)؛ الحسابات تعمل عبر city timezone وDST نجح — يتبع CR-0010 قبل الإضافة.



\---



\## Phase 04 — Notifications & Adhan
- Status: ✅ COMPLETED (2026-10-12)
- Duration: 2 days (2026-10-10 → 2026-10-12)
- Tasks: 1-12 (11c PARTIAL → Phase 05+, 12 device-verified 2:34 full play)
- Tests: 489/489
- Bugs: BUG-7 (WAV→OGG) CLOSED
- Output Report: docs/phase-04-output-report.md

## Remaining Deferrals
- CR-0015 Multi-Adhan (Phase 05+).
- Task 11c real call (Phase 05 device session).
- GAPs: task6-device-interruption (P2), boot-no-recalc, format-time-dup, night-thirds-2x-calc, all-prayers-disabled-hint, license-page, cr0013-photo, integration-player-race, deeplink-host-loss (P3).

## المراحل المكتملة



| المرحلة | Status | التاريخ | Output Report |

|---|---|---|---|

| Phase 00 — Foundation | ✅ APPROVED | 2026-10-06 | `docs/phase-00-output-report.md` |



\### Phase 00 — ملخص ما تحقق



\- ✅ `flutter analyze --fatal-infos` (No issues)

\- ✅ `flutter test` (1/1 pass)

\- ✅ `flutter build apk --debug` (Built)

\- ✅ CI على PR تجريبي (run 37384176239 — success)

\- ✅ GitHub repo + push

\- ✅ 10 مخرجات أساسية



\---



\## المراحل القادمة



| المرحلة | الإصدار | Prerequisites | Blockers |

|---|---|---|---|

| Phase 01 — Foundation | v0.1 | 00B مكتملة | IN PROGRESS — data layer complete; OD-0008, OD-0010, OD-0012, OD-0013 decided (DEC-0024–0027) |

| Phase 02 — Prayer | v0.2 | 01 | ✅ OD-0011/OD-0025 resolved; package CRs remain before package use |



\---



\## آخر 5 commits



\*(يُحدَّث من `git log --oneline -5`)\*

(git log --oneline -5 هنا)



text



\---



\## آخر 5 قرارات (DECs)



| DEC | التاريخ | الموضوع |
|---|---|---|
| DEC-0027 | 2026-10-06 | Hive encryption |
| DEC-0026 | 2026-10-06 | Numerals |
| DEC-0025 | 2026-10-06 | Local error log |
| DEC-0024 | 2026-10-06 | User data migrations |
| DEC-0023 | 2026-10-06 | Notification receivers manual addition |

| DEC-0017 | 2026-10-06 | Pixel 6a (reference device) |

| DEC-0016 | 2026-10-05 | Riverpod 2.6.1 (exact pin) |

| DEC-0015 | 2026-10-05 | Android only, minSdk 24 |

| DEC-0014 | 2026-10-05 | MIT License |



\---



\## Change Requests (CRs)



| CR | الموضوع | الحالة |

|---|---|---|

| CR-0001 | CI rollout (Phase-Aware) | ✅ APPROVED |

| CR-0002 | Phase A → Phase 00 (تسمية) | ✅ APPROVED |

| CR-0003 | minSdk 24 (تعديل DEC-0015) | ✅ APPROVED |

| CR-0004 | audio\_service + just\_audio في spike | ✅ APPROVED |
| CR-0005 | توسيع عقد أسماء CI jobs | ✅ APPROVED |
| CR-0006 | path_provider في التطبيق الرئيسي | ✅ APPROVED |
| CR-0007 | compileSdk 36 لدعم share_plus | ✅ APPROVED |



\---



\## Open Decisions المؤثرة الآن



\*\*لا OD تعطّل Phase 00B حالياً.\*\*

**Phase 02:** OD-0011 وOD-0025 حُسمتا في DEC-0028 وDEC-0029؛ OD-0019 محسومة في DEC-0017.



### OD-0008/0010/0012/0013 — DECIDED for Phase 01



| OD | الموضوع | Status |

|---|---|---|

| OD-0008 | ترحيل بيانات المستخدم (schemaVersion + migrations) | DECIDED — DEC-0024 |
| OD-0010 | سجل الأخطاء المحلي (صيغة + تصدير) | DECIDED — DEC-0025 |
| OD-0012 | الأرقام (عربية هندية أم لاتينية) | DECIDED — DEC-0026 |
| OD-0013 | تشفير Hive (اختياري + تخزين المفتاح) | DECIDED — DEC-0027 |



\---



\## ملفات مهمة



\### المرحلة الحالية

\- `phases/00b-spike.md`

\- `spike/` (مشروع تجريبي — سيُحذف بعد 00B)

\- `governance/cr/CR-0004-audio-in-spike.md`



\### بنية المشروع الرئيسي

\- `lib/` — الكود الرئيسي (لم يُلمس بعد)

\- `test/` — اختبارات الجذر

\- `tool/` — سكربتات CI (5 سكربتات جديدة)

\- `.github/workflows/ci.yml` — 9 jobs (4 أساسية + 5 جديدة)



\### الوثائق الأساسية

\- `README.md` — نقطة الدخول

\- `00-integrity-rules.md` — 20 قاعدة

\- `governance/01-ai-development-rules.md` — قواعد الوكيل

\- `03-decisions.md` + `04-open-decisions.md`

\- `05-conflicts-and-gaps.md`

\- `06-defect-register.md`



\---



\## ملاحظات حرجة



1\. \*\*لا تلمس `lib/` في Phase 00B\*\* — كل شيء داخل `spike/`.

2\. \*\*جهاز فيزيائي مطلوب\*\* — Pixel 6a أو Redmi Note 12 (DEC-0017).

3\. \*\*`spike/` معفى من CI-015/016\*\* — عبر `legal/policy.yaml`.

4\. \*\*baseline test count = 2\*\* — لا تنزل تحته (CI-012).

5\. \*\*SHA pinning إلزامي\*\* في GitHub Actions (Rule 019).



\---



\## مسار النجاح

Phase 00B step 3 → push + PR → راجع CI

↓

Phase 00B step 4 → بناء Spike كامل

↓

Phase 00B step 5 → اختبار وظيفي

↓

Phase 00B step 6 → جهاز فيزيائي

↓

Phase 00B مكتملة → Phase 01
