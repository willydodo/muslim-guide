# CR-0019 — hijri package

**Status:** APPROVED
**Date:** 2026-10-17

**Decision:** إضافة `hijri 3.0.1` (BSD-2-Clause) كتبعية مباشرة.

**Reason:**
- حساب هجري عبر Umm al-Qura مضمّن.
- Offline كامل (صفر dependencies، بلا شبكة، بلا جدول خارجي).
- تعديل مستخدم ±1 عبر `setAdjustments` الأصيل.

**Package Details:**
- Version: 3.0.1 (exact pin).
- License: BSD-2-Clause (OSI-approved، متوافق مع MIT).
- Published: ~4 months ago (تحقق pub.dev 2026-10-17).
- Publisher: unverified uploader (مخاطرة صيانة متوسطة).
- Dependencies: zero.
- Platforms: 6/6 (Android, iOS, Web, Windows, macOS, Linux).
- Score: 140/160 pub points، ‏31.7k تحميل.
- Caveat: توثيق داخلي ضعيف (1.7% dartdoc) + 8 infos داخلية —
  لا تأثير على كودنا (نعزلها خلف `HijriCalculator`).

**Consequences:**
- `pubspec.yaml` + `pubspec.lock`.
- `LICENSES.md` + `security/02-dependencies.md`.
- Closes OD-0005 مع DEC-0033.

**Alternatives:**
- جدول أم القرى PD مستقل: مرفوض (غير متاح — الموقع الرسمي
  بلا جدول قابل للتحميل؛ `tytkal/ummalqura` يعطي 404).
- حساب فلكي/جدولي يدوي: مرفوض (ليس أم القرى؛ انحراف ±1–2 يوم).
- `flutter_hijri_date_picker`: مرفوض (حزمة UI إضافية غير ضرورية).

**Approved By:** Abdo
