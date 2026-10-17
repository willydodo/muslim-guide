# Phase 05c — Tasbih Counter (عدّاد التسبيح)

## Status
DRAFT (spec only — no code before Abdo approval)

## Objective

بناء عدّاد تسبيح تفاعلي بسيط يعمل Offline بالكامل:
7 صيغ ثابتة بأرقام الحديث (مسلم 597، 2691، 2693، 2702 + البخاري 6384) —
عدّاد دائري + Haptic، قسمان: بعد الصلاة (33/33/34 تسلسل) + تسبيح حر (100×).

## Scope

### الصيغ (7 — بأرقام الحديث)

| # | id | النص | العدد | المصدر |
|---|---|---|---|---|
| 1 | subhanallah | سُبْحَانَ اللَّهِ | 33 | مسلم 597 |
| 2 | alhamdulillah | الْحَمْدُ لِلَّهِ | 33 | مسلم 597 |
| 3 | allahuakbar | اللَّهُ أَكْبَرُ | 34 | مسلم 597 |
| 4 | subhanallah_wa_bihamdihi | سُبْحَانَ اللَّهِ وَبِحَمْدِهِ | 100 | مسلم 2691 |
| 5 | la_ilaha_illallah | لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ | 100 | مسلم 2693 |
| 6 | astaghfirullah | أَسْتَغْفِرُ اللَّهَ | 100 | مسلم 2702 |
| 7 | la_hawla_wa_la_quwwata | لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ | 100 | البخاري 6384 |

> النصوص الكاملة تُستخرج من HadeethEnc (نفس مسار 05b: verbatim + grade +
> attribution) — **لا كتابة من الذاكرة** (Stop 7). التأليف HadeethEnc IDs
> فقط، والنص يأتي من API.

### الأقسام
- **بعد الصلاة:** 33/33/34 (تسلسل: subhanallah ← alhamdulillah ← allahuakbar).
- **تسبيح حر:** 100× (كل ذكر مستقل: 4-7).

### داخل النطاق
- شاشة `TasbihListScreen`: قائمة الأذكار السبعة (قسمان: بعد الصلاة + تسبيح حر).
- شاشة `TasbihScreen`: Circular Progress (progress ring) + الزر الرئيسي في
  المنتصف (اضغط للعد) + العد الحالي (33/100) + زر "إعادة".
- Haptic خفيف عند كل عد (عبر `vibration` أو `flutter/services` —
  يُحسم في التنفيذ، بلا حزمة جديدة إن أمكن).
- حفظ تقدّم اليوم فقط في Hive `Box<dynamic>` بمفاتيح `tasbih_<id>_count`
  (int) و`tasbih_<id>_target` (int) — reset عبر `delete` المفتاح، بلا migration.
- Deep link لكل ذكر: `muslimguide://tasbih/<id>` → `TasbihScreen`
  (`<id>` من جدول الصيغ أعلاه).
- AR/EN للواجهة فقط (~10 keys)؛ النص الديني RTL ثابت (DEC-0026).
- 5 حالات: Loading / Empty / Error / Success (لا Refreshing).

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
1. ~~مصدر النصوص~~ — **محسوم:** أرقام الحديث أعلاه (مسلم 597، 2691، 2693،
   2702 + البخاري 6384)؛ النص الكامل يُستخرج من HadeethEnc (IDs تُسجَّل في
   Task 1) — لا نص بلا مصدر معتمد (Stop 1).
2. ~~Hive schema~~ — **محسوم:** `Box<dynamic>` + مفاتيح `tasbih_<id>_count` /
   `tasbih_<id>_target`، بلا migration (مفتاح جديد)، reset عبر `delete`.
3. ~~Deep link~~ — **محسوم:** `muslimguide://tasbih/<id>` لكل ذكر + intent-filter.

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
1. Spec + قرارات (هذه المواصفة — DRAFT → APPROVED من Abdo).
2. استخراج الـ7 من HadeethEnc (IDs + grade + attribution) — gaps تُسجَّل.
3. بناء `tasbih.json` (PENDING_REVIEW) + checksum + HTML → مراجعة shaykh-1 → دمج.
4. Domain (`TasbihEntry` model) + Data (Hive repository + fake) — بعد الاعتماد.
5. Application (providers: tasbih list + current session).
6. Presentation (`TasbihListScreen` + `TasbihScreen` + Circular Progress + haptic).
7. Router + deep link `muslimguide://tasbih/<id>` + ARB (~10 keys).
8. Tests (unit + widget + integration) + analyze + build.
9. Device test (Oppo A95 — Abdo).

## Tests Required
- Unit (≥8): `TasbihEntry` model، Hive repository، session/list providers.
- Widget (≥6): `TasbihScreen` (progress، reset، haptic) + `TasbihListScreen`.
- Integration (≥2): full flow (قائمة ← عدّاد ← إكمال ← reset).
- Content: schema + checksum + لا placeholder + لا نص من الذاكرة.
- Failure: pack تالف/missing → Error؛ Hive unavailable → رسالة واضحة.
- Device (مطلوب): Oppo A95 — Abdo.

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
- [ ] deep link `muslimguide://tasbih/<id>` يعمل لكل id (merged manifest مفحوص).

## Evidence Required
- ناتج `flutter analyze --fatal-infos` حرفيًا.
- ناتج `flutter test` حرفيًا.
- ناتج `flutter build apk --debug` حرفيًا.
- الدليل الشرعي/القانوني (HadeethEnc IDs + snapshot + checksum).
- merged manifest (intent-filter التسبيح).

## Deviations from Specification
- استبدال الصيغ 4/5/7: (2692 ← 2691)، (2691 ← 2693)، (2694 "العظيم" ← البخاري
  6384 "لا حول ولا قوة") — بقرار Director (أرقام الحديث الثابتة).
- Deep link: `muslimguide://tasbih` (path-only) ← `muslimguide://tasbih/<id>`
  لكل ذكر — بقرار Director.
- Hive: "بلا TypeAdapter" ← `Box<dynamic>` + مفاتيح `tasbih_<id>_count/target`
  صراحةً — بقرار Director.
- Haptic: "اختياري" ← خفيف إلزامي عند كل عد — بقرار Director.
- Tasks: 5 ← 9 مهام مفصلة — بقرار Director.

## Human Review Points
- **شرعي:** اعتماد الصيغ الـ7 (shaykh-1، Rule 020).
- **ترخيص:** HadeethEnc NoDerivs + evidence (CR-0020 سارٍ).
- **معماري:** feature جديد أم توسيع azkar + Hive schema + deep link.

## Approval
- Status: DRAFT (spec only — بانتظار Abdo)
- Approved By: —
- Approval Date: —
- Approval Text: —
