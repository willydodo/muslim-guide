# Phase 05c — Tasbih Counter (عدّاد التسبيح)

## Status
PLANNED (spec only — no code before Abdo approval)

## Objective

بناء عدّاد تسبيح تفاعلي بسيط يعمل Offline بالكامل، بلا مصادر معقدة:
7 صيغ ثابتة من صحيح مسلم (597، 2691، 2693، 2694، 2702) — النص والدرجة
معروفان ولا يحتاجان تحققًا خارجيًا.

## Scope

### الصيغ (7 — من صحيح مسلم)

| # | النص | العدد | المصدر |
|---|---|---|---|
| 1 | سُبْحَانَ اللَّهِ | 33 | مسلم 597 |
| 2 | الْحَمْدُ لِلَّهِ | 33 | مسلم 597 |
| 3 | اللَّهُ أَكْبَرُ | 34 | مسلم 597 |
| 4 | سُبْحَانَ اللَّهِ وَبِحَمْدِهِ | 100 | مسلم 2692 |
| 5 | لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ... | 100 | مسلم 2691 |
| 6 | أَسْتَغْفِرُ اللَّهَ | 100 | مسلم 2702 |
| 7 | سُبْحَانَ اللَّهِ الْعَظِيمِ | 100 | مسلم 2694 |

### داخل النطاق
- عدّاد تفاعلي (tap + اهتزاز خفيف اختياري) + تقدّم دائري.
- حفظ تقدّم اليوم فقط في Hive (ليس النص) — بلا TypeAdapter جديد (DEC-0024).
- AR/EN للواجهة فقط؛ النص الديني RTL ثابت (DEC-0026).
- 5 حالات: Loading / Empty / Error / Success (لا Refreshing).
- Deep link واحد path-only: `muslimguide://tasbih` (نمط Phase 04/05).

### ملاحظة حوكمة
- النصوص الـ7 تُستخرج من HadeethEnc (نفس مسار 05b: verbatim + grade + attribution)
  أو تُسجَّل كفجوة إن غابت — **لا كتابة من الذاكرة** (Stop 7).
- المراجع: shaykh-1 (نطاق `azkar-hisn` يغطي التسبيح).
- الحالة الابتدائية لكل عنصر: `PENDING_REVIEW`.

## Out of Scope

- أي توسع أذكار beyond الـ7 (→ v1.5 + GAP-azkar-expansion-deferred).
- صوت/تلاوة (→ v1.5 + OD-0007).
- مفضلة/إحصائيات أسبوعية (→ Phase 10/11).
- Widgets.

## Requirements
- **REQ-AZKAR-001** — PROPOSED extension: عدّاد التسبيح من pack معتمد.
- **REQ-L10N-001** — ARB فقط؛ RTL ثابت للنص الديني.
- **REQ-A11Y-001** — هدف لمس ≥ 48dp، تباين AA، Semantics، تكبير 200% بلا قص.
- **REQ-PRIVACY-001** — لا شبكة.

## Dependencies
- **Phase 05 ✅** — نمط Azkar skeleton + providers + deep link.
- **Phase 05b ✅** — مسار HadeethEnc + review workflow.
- **DEC-0024** — أي schema جديد يتطلب migration.
- **DEC-0026** — أرقام Latin للواجهة.

## Decisions Required
1. **مصدر النصوص الـ7**: HadeethEnc (IDs تُسجَّل) أم إدخال يدوي موثق من مسلم؟ (Stop 1 — لا نص بلا مصدر معتمد).
2. **Hive schema**: هل يكفي `Box<dynamic>` للتقدم أم نموذج + migration؟ (Stop 13).
3. **Deep link**: تأكيد `muslimguide://tasbih` path-only + intent-filter.

## Architecture Changes
- `lib/features/tasbih/` (feature-first: domain/data/application/presentation) —
  أو توسيع `lib/features/azkar/` بقرار معماري موثق.
- `assets/content/azkar/tasbih.json` — schema `08-review-workflow`
  (pack_id/version/checksum/approval، status ابتدائي PENDING_REVIEW).

## Files Expected
- `assets/content/azkar/tasbih.json`
- `tool/build_tasbih_pack.py` (استيراد HadeethEnc قابل لإعادة التشغيل)
- `content/reviews/tasbih-review-<date>.html` + `.json`
- `lib/features/tasbih/...` (بعد APPROVED فقط)
- `test/...` (unit + widget section-specific)

## Implementation Tasks
1. استخراج الـ7 من HadeethEnc (IDs + grade + attribution) — gaps تُسجَّل.
2. بناء `tasbih.json` (PENDING_REVIEW) + checksum + HTML.
3. مراجعة shaykh-1 → دمج → PARTIALLY_APPROVED/APPROVED.
4. Flutter (بعد الاعتماد): domain/data/providers/screens/widgets.
5. Tests + analyze + build + device test (Oppo A95).

## Tests Required
- Unit: عدّاد/تقدّم/progress storage.
- Widget: section-specific (عداد، تقدّم، RTL، 200%).
- Content: schema + checksum + لا placeholder + لا نص من الذاكرة.
- Failure: pack تالف/missing → Error؛ Hive unavailable → رسالة واضحة.

## CI Requirements
- `flutter analyze --fatal-infos` صفر + `flutter test` أخضر + debug APK.
- فحص لا `INTERNET` + baseline testIDs.

## Risks
1. **نص من الذاكرة** (الأعلى): التخفيف — HadeethEnc فقط + content-check + مراجع.
2. **تضخم النطاق**: التخفيف — 7 صيغ فقط، لا توسع.
3. **Layout-coupling**: التخفيف — section-specific tests.

## Known Gaps
- GAP-azkar-expansion-deferred (P2): التوسع الكامل مؤجل.
- النصوص الـ7 بلا IDs مثبتة بعد — تُستخرج في Task 1.

## Exit Criteria
- [ ] Task 1 موثق: 7 IDs + grades + checksum + `legal/assets.yaml`.
- [ ] مراجعة shaykh-1 مدموجة (PARTIALLY_APPROVED على الأقل).
- [ ] `flutter analyze --fatal-infos` صفر، `flutter test` أخضر، debug APK.
- [ ] جهاز Oppo A95: عدّاد/RTL/تكبير 200%/TalkBack + offline.
- [ ] deep link `muslimguide://tasbih` يعمل (merged manifest مفحوص).

## Evidence Required
- ناتج `flutter analyze --fatal-infos` حرفيًا.
- ناتج `flutter test` حرفيًا.
- ناتج `flutter build apk --debug` حرفيًا.
- الدليل الشرعي/القانوني (HadeethEnc IDs + snapshot + checksum).
- merged manifest (intent-filter التسبيح).

## Deviations from Specification
- لا يوجد (spec أولي — بانتظار مراجعة Abdo).

## Human Review Points
- **شرعي:** اعتماد الصيغ الـ7 (shaykh-1، Rule 020).
- **ترخيص:** HadeethEnc NoDerivs + evidence (CR-0020 سارٍ).
- **معماري:** feature جديد أم توسيع azkar + Hive schema + deep link.

## Approval
- Status: PLANNED (spec only)
- Approved By: —
- Approval Date: —
- Approval Text: —
