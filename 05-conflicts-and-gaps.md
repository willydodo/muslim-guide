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

### GAP-azkar-expansion-deferred — Full Azkar/Adiya expansion deferred
- **Finding**: `الأذكار.docx` contains 304 entries (not 382 — Director estimate corrected, no second file).
- **Reasons**: (1) dorar.net/sunnah.com blocked (HTTP 403 — no automated verification possible);
  (2) `dorar_hadith` package requires drift (blocked by OD-0002 until Phase 12);
  (3) external verification duplicates degrees already present in the file itself.
- **Decision**: v1.0 = 7 approved morning adhkar only (`morning.json`, PARTIALLY_APPROVED).
- **Priority**: P2 | **Phase**: 07 (frozen) | **Status**: OPEN (deferred to Phase 09+)
- **Date**: 2026-10-17
