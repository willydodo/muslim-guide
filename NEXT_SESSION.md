# NEXT SESSION — Phase 06 Device Test

> **آخر تحديث:** 2026-10-17
> **المرحلة:** Phase 06 Task 2 ✅ مكتمل

## حالة المشروع

| البند | القيمة |
|---|---|
| Repo | `willydodo/muslim-guide` |
| HEAD | `614ad734a5442570cd1c982c16ba1aa8482056cf` |
| CI | ⏳ يُتحقق يدويًا (لا وصول API من هنا) |
| approvals | APR-0001 + APR-0002 APPROVED |
| tags | approval/phase-A-v1, approval/phase-B-v1 |

## المراحل المكتملة

- Phase 00 → 04 ✅
- Phase 05 (Azkar skeleton) ✅
- **Phase 06 Task 1 (Quran data)** ✅
- **Phase 06 Task 2 (Mushaf View)** ✅

## المتبقي — Phase 06 Device Test (1-2 ساعة)

### الجهاز
- **Oppo A95** (CPH2365, Android 13, ColorOS) — متصل (`db692b78`)

### الاختبارات
1. فتح التطبيق → Splash → Home
2. القرآن → فهرس 114 سورة
3. الفاتحة → Mushaf view
4. ضغط آية → Sheet
5. نسخ → SnackBar
6. مشاركة → Share sheet
7. عُد للفهرس
8. البقرة (286 آية) → scroll سلس
9. **Cold start < 2.0s**
10. تبديل EN → الواجهة EN
11. Text scale 200% → بلا overflow
12. وضع طيران → يعمل

### Evidence
- `docs/phase-06-output-report.md`
- لقطات شاشة

## المراحل القادمة

### Phase 06b (اختياري — التفاسير)
- تفسير ابن كثير + البغوي + الطبري
- shamela.ws (Public Domain)
- OD-0028

### Phase 07 (التلاوة)
- Wikimedia Commons CC0
- OD-0007
- audio_service + just_audio

### Phase 08 (التقويم)
- OD-0005

### Phase 09 (v1.0)
- تثبيت + إطلاق

## البروتوكول

**افتح جلسة جديدة:**
1. اقرأ `NEXT_SESSION.md`
2. اقرأ `docs/DIRECTOR_PLAYBOOK.md`
3. اقرأ `phases/06.md`
4. أجب على الأسئلة (وفق DIRECTOR_PLAYBOOK)
5. انتظر موافقة Abdo
