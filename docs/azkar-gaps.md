# Azkar Gaps — Morning (Pilot)

> **التاريخ:** 2026-10-17
> **المراجع:** shaykh-1
> **الحزمة:** `assets/content/azkar/core/morning.json` (v0.1.0, PARTIALLY_APPROVED)

## Rejected Items (بلا سبب)

### morning_002 (HadeethEnc 5490 — حسن)
- **الحالة:** REJECTED (shaykh-1، بلا ملاحظات).
- **العنوان:** اللهم بك أصبحنا، وبك أمسينا، وبك نحيا، وبك نموت، وإليك النشور.
- **الإجراء:** محفوظ في JSON للتوثيق (`review.status=rejected`)، مستبعد من الإنتاج.
- **البديل:** TBD — بانتظار توضيح سبب الرفض من المراجع.
- **التاريخ:** 2026-10-17

### morning_007 (HadeethEnc 65260 — صحيح)
- **الحالة:** REJECTED (shaykh-1، بلا ملاحظات).
- **العنوان:** كان لا ينام حتى يقرأ الم تنزيل، وتبارك الذي بيده الملك.
- **الإجراء:** محفوظ في JSON للتوثيق، مستبعد من الإنتاج.
- **البديل:** TBD — بانتظار توضيح سبب الرفض من المراجع.
- **التاريخ:** 2026-10-17

## Edited Items (التعديل مرفوض — نص HadeethEnc باقٍ)

### morning_003 (HadeethEnc 5503 — سيد الاستغفار)
- **الحالة:** approved مع `proposed_text` محفوظ مزدوجًا.
- **المقترح:** نص من صحيح البخاري (سند ومتن مختلفان تمامًا).
- **الإجراء:** `edit_decision=REJECTED`.
- **السبب:** HadeethEnc NoDerivs + البخاري غير مرخص في `assets.yaml`.
- **ملاحظة:** قد يُعاد لاحقًا عبر CR-0022 إذا وُثّق ترخيص البخاري.

### morning_006 (HadeethEnc 3008 — أمسينا وأمسى الملك لله)
- **الحالة:** approved مع `proposed_text` محفوظ مزدوجًا.
- **المقترح:** صياغة مختلفة (ملاحظة المراجع: صحيح مسلم 2723).
- **الإجراء:** `edit_decision=REJECTED`.
- **السبب:** HadeethEnc NoDerivs.
- **ملاحظة:** قد يُعاد لاحقًا.

## Translation Gaps

- `morning_007` (65260): بلا ترجمة إنجليزية في API (HTTP 404).
- `morning_008` (66086): بلا ترجمة إنجليزية في API (HTTP 404).

## Notes

### morning_001 (صحيح)
- **الملاحظة:** "صحيح" — لا تضيف شيئًا (الدرجة أصلًا صحيح من المصدر).
- **الإجراء:** مقبول (approved).

## Summary

- total: 9 — approved: 7 (منها 2 بتعديل مرفوض) — rejected: 2
- status: PARTIALLY_APPROVED (ليس APPROVED كاملًا).
