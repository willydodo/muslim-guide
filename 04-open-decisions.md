# Open Decisions

## OD-0001 — ترخيص الكود
- **Question**: MIT أم GPL؟
- **Blocking Phase**: قبل Phase 00
- **Status**: DECIDED — MIT License (DEC-0014، 2026-10-05)
- **Note**: يحدد توافق ترخيص المكتبات والمحتوى.

## OD-0002 — drift
- **Question**: هل نستخدم drift إلى جانب Hive؟
- **Blocking Phase**: قبل Phase 12
- **Status**: OPEN
- **Rule**: لا يُدخل drift قبل حسم هذا.

## OD-0003 — تنسيق تخزين القرآن
- **Question**: JSON واحد أم SQLite كـasset؟
- **Blocking Phase**: Phase 06
- **Status**: CLOSED — JSON (`assets/content/quran/quran-uthmani.json`), DEC-0030 (2026-10-16)
- **Criterion**: cold start < 2.0s على الجهاز المرجعي؛ القياس ما زال مطلوبًا.

## OD-0004 — تطبيع البحث العربي
- **Question**: قواعد التطبيع (تشكيل، همزات، ألف مقصورة، تاء مربوطة)؟
- **Blocking Phase**: Phase 12
- **Status**: OPEN
- **Note (2026-10-16)**: البحث معطّل في Phase 06؛ يُحسم هذا القرار في Phase 12.

## OD-0005 — التقويم الهجري
- **Question**: أم القرى / فلكي / خيار للمستخدم؟
- **Blocking Phase**: قبل Phase 08
- **Status**: OPEN

## OD-0006 — المنصات
- **Question**: Android min SDK؟ iOS ضمن v1؟
- **Blocking Phase**: قبل Phase 01
- **Status**: DECIDED — Android فقط في v1.0 (minSdk 24, compileSdk 36, targetSdk 34)؛ iOS مؤجل إلى v2.0+ → OD-0021 (DEC-0015، 2026-10-05؛ minSdk amended by CR-0003 وcompileSdk amended by CR-0007 on 2026-10-06)

## OD-0007 — Recitation audio source

**Status:** OPEN
**Blocking Phase:** 07 (deferred to v1.5)
**Date:** 2026-10-17

**Question:** ما مصدر صوت التلاوة بحقوق إعادة نشر مثبتة؟

**Context (verified 2026-10-17):**
- Wikimedia Commons: لا مصحف كامل (52 تسجيلاً متفرقاً فقط —
  سور قصار + مقاطع جزئية، لا 114 سورة من قارئ واحد).
- Archive.org: حقوق محفوظة (قراء مشهورون توفوا 1969–1988م؛
  لا PD قبل 1929م للتسجيل الصوتي؛ عنصر `quran_mp3` بلا بيان ترخيص).
- EveryAyah: لا صفحة شروط قابلة للقراءة (صفحات فارغة/404).
- لا مصدر APPROVED. `quran-recitation` = DEFERRED (CR-0018).

**Options:**
- A: مراسلة EveryAyah/قارئ واحد (2-6 أسابيع).
- B: إسقاط من v1.0 → v1.5 (الحالي).
- C: إيجاد مصدر PD آخر.

**Decision:** B — مؤجل لـv1.5 (CR-0018، 2026-10-17).

## OD-0008 — ترحيل بيانات المستخدم
- **Question**: آلية schemaVersion وmigration؟
- **Blocking Phase**: Phase 01
- **Status**: DECIDED — simple versioned migrations (DEC-0024، 2026-10-06)

## OD-0009 — النشر على المتاجر
- **Question**: توقيع، Data Safety، سياسة خصوصية؟
- **Blocking Phase**: قبل Phase 09
- **Status**: OPEN

## OD-0010 — سجل الأخطاء المحلي
- **Question**: صيغة وتصدير؟
- **Blocking Phase**: Phase 01
- **Status**: DECIDED — JSON Lines in Documents with bounded rotation and manual share export (DEC-0025، 2026-10-06)

## OD-0011 — طريقة حساب المواقيت
- **Question**: الطريقة الافتراضية وخيارات المستخدم؟
- **Blocking Phase**: قبل Phase 02
- **Status**: DECIDED — MWL default, seven calculation methods, Standard/Hanafi Asr, and MiddleOfNight default (DEC-0028، 2026-10-07)

## OD-0012 — الأرقام
- **Question**: عربية هندية أم لاتينية؟
- **Blocking Phase**: Phase 01
- **Status**: DECIDED — Latin numerals in UI; Arabic-Indic numerals in Quranic text (DEC-0026، 2026-10-06)

## OD-0013 — تشفير Hive
- **Question**: اختياري؟ أين يُخزن المفتاح؟
- **Blocking Phase**: Phase 01
- **Status**: DECIDED — no encryption in v1; revisit through a new OD if data sensitivity changes (DEC-0027، 2026-10-06)

## OD-0014 — cache eviction للصوت
- **Question**: سياسة الحدود والتحميل؟
- **Blocking Phase**: قبل Phase 07
- **Status**: OPEN

## OD-0015 — ترجمات المحتوى
- **Question**: مصدر معتمد، تمييز النص عن الترجمة؟
- **Blocking Phase**: قبل Phase 19
- **Status**: OPEN

## OD-0016 — عدد اللغات بعد v1
- **Question**: ما الإضافات؟
- **Blocking Phase**: بعد v1
- **Status**: OPEN

## OD-0017 — home widgets
- **Question**: نعم أم لا؟ التكلفة مقابل التوقع؟
- **Blocking Phase**: قبل Phase 09
- **Status**: OPEN

## OD-0018 — إصدار Riverpod
- **Question**: 2.x أم 3.x؟
- **Blocking Phase**: قبل Phase 00
- **Status**: DECIDED — flutter_riverpod 2.6.1 (آخر إصدار 2.x ثابت، تحقق pub.dev 2026-10-05) → DEC-0016
- **Rule**: لا تثبيت قبل التحقق من pub.dev + استقرار + migration path.

## OD-0019 — الجهاز المرجعي
- **Question**: ما الطراز والمواصفات؟
- **Blocking Phase**: Phase 00
- **Status**: DECIDED (DEC-0017)
- **Decision**: Pixel 6a أساسي + Redmi Note 12 ثانوي
- **Date**: 2026-10-06
- **Proposal**: Pixel 6a أو Redmi Note 12.

## OD-0020 — Amiri Quran License
- **Question**: هل يسمح بالاستخدام التجاري؟ (التطبيق مجاني، لكن التوزيع تجاري بمعنى النشر على المتاجر)
- **Blocking Phase**: قبل Phase 06
- **Status**: OPEN

## OD-0021 — iOS بعد v1.0
- **Question**: متى يُضمّن iOS وما دعمه (الإصدار الأدنى، القناة)؟
- **Blocking Phase**: قبل v2.0
- **Status**: OPEN
- **Origin**: DEC-0015 (أُجّل iOS إلى v2.0+، 2026-10-05)

## OD-0022 — جهاز اختبار Phase 00B

**Question:** ما الجهاز المتاح لتنفيذ Step 5؟

**Why It Matters:** 60% من مخاطر الإشعارات لا تكتشف على المحاكي.

**Options:**
- A: Pixel 6a (المفضل — بلا تحسينات بطارية)
- B: أي Android 7+ (كافٍ للاختبار الأساسي)
- C: تأجيل إلى Phase 04

**Blocking Phase:** Phase 04 (الأذان)

**Status:** CLOSED — Step 5 completed on CPH2365 / Android 13 on 2026-10-06.

**Deadline:** قبل بدء Phase 04

## OD-0023 — Audio focus verification

**Question:** Does playback stop or resume correctly when an incoming phone call interrupts it?

**Blocking Phase:** 04

**Status:** OPEN

**Context:** Audio focus could not be tested without a real incoming call.

**Action:** Verify interruption and resume behavior during Phase 04 using a real call.

## OD-0024 — OEM long-term behavior

**Question:** Do notifications remain reliable under long-term ColorOS and other OEM background restrictions?

**Blocking Phase:** 04

**Status:** OPEN

**Context:** Step 5 verified foreground, background-with-exemption, and reboot delivery on one CPH2365 device, but did not run for 30+ minutes or test additional OEM devices.

**Action:** Run a 30+ minute test on multiple OEM devices during Phase 04 and document the required battery, background-running, and auto-launch guidance.

## OD-0025 — Automatic timezone detection

**Status:** DECIDED — use `flutter_timezone`, with `Asia/Riyadh` fallback and a local warning on failure (DEC-0029، 2026-10-07)
**Blocking Phase:** 02

**Question:** How should the user's timezone be detected automatically?

**Options:**
- A: `flutter_timezone` (reads the system timezone)
- B: `DateTime.now().timeZoneName` (may be inaccurate)
- C: User-configurable setting

**Current (Phase 01):** `Asia/Riyadh` is temporary and must be replaced before
production.

**Decision:** `flutter_timezone` (DEC-0029). CR-0010, package/license verification, and exact version pin are required before adding the dependency.

## OD-0026 — Diyanet calculation method

**Status:** OPEN
**Blocking Phase:** None (deferred)
**Type:** Future enhancement

**Question:** Should Diyanet be added as an eighth calculation method?

**Why It Matters:**
- Diyanet is the official prayer-time authority in Turkey and may serve Turkish communities.

**Current Blocker:** No verified official or peer-reviewed source documents the complete calculation profile:
- Fajr angle.
- Isha angle.
- Dhuhr offset.
- Asr method.
- High-latitude rule.

**Available but Insufficient:**
- Aladhan lists Turkey as experimental with Fajr 18° and Isha 17° only.
- Diyanet's public pages describe astronomical calculation but do not publish the complete parameters.

**Resolution Path:**
- [ ] Find an official Diyanet document with the complete parameters.
- [ ] Or find a peer-reviewed paper documenting them.
- [ ] Or contact Diyanet directly.
- [ ] Record the verified values in a new DEC before implementation.

**Decision Required From:** User
**Deadline:** None — deferred.

## OD-0027 — Alternative prayer times when astronomical events are unavailable

**Status:** OPEN — deferred; no blocker for the current Domain behavior
**Blocking Phase:** Future enhancement

**Question:** Should the product offer a non-astronomical substitute for a
prayer time when the sun does not reach the required position at the user's
location?

**Options to evaluate:**
- Keep the affected times unavailable and show an explanation.
- Offer a neighboring-location rule (Aqrab al-Bilad).
- Offer a neighboring-day rule (Aqrab al-Ayyam).

**Current Phase 02 behavior:** The Domain returns `null` for an event that
cannot be determined astronomically. It does not substitute another day or
location. Other calculable times remain available. High-latitude rules only
adjust times when the relevant sunrise/sunset anchors exist.

**Resolution required before:** Any future implementation of substitute
prayer times. Record the religious/legal review and UX decision before
changing this behavior.

## OD-0028 — Asr at high latitudes (>66°N)

**Status:** CLOSED — accept-as-known-limitation (2026-10-09, Phase 03 Task 3)
**Target Phase:** 03
**Blocking Phase:** None
**Type:** Verification
**Priority:** P2 (escalated from Low — systematic pattern confirmed)

**Context:** Tromsø (69.65°N), 2026-10-07:
- Our Asr: `14:37:23`
- Aladhan MWL: `14:43:00`
- Difference (`ours - reference`): `-5m37s`, 37 seconds beyond the ±5-minute
  high-latitude tolerance.

**Escalation basis (2026-10-09 device testing):** the shift is systematic,
not a one-off — Asr ran `-2m`/`-3m` early across the eight-city matrix
(T3, 42/48; every breach is Asr), `-8m` in Tromsø on 2026-10-09 (T3), and
`-3m` in London DST (M3/T4). Investigation required in Phase 03 before
that phase closes.

**Analysis:** The project owner reports an independent Meeus-based manual Asr
calculation of approximately `14:36`, close to the calculator output. Aladhan
may apply a high-latitude Asr adjustment. Its value is a secondary reference,
not an official determination.

**Action:** (all completed 2026-10-09 — see Resolution)
- Verify against additional high-latitude cities, including Reykjavík and
  Murmansk.
- Cross-check with an independent source or calculation.
- Decide whether the difference reflects the reference convention or requires
  a code change; do not change the algorithm based only on this one secondary
  comparison.

**Resolution (2026-10-09 — Phase 03 Task 3):** **CLOSED —
accept-as-known-limitation.** The calculator is not defective: app output
equals the PrayTimes.js v2.5 original at **0s across 12/12 probes**
(Tromsø included), corroborated by the owner's independent Meeus check
(≈14:36 vs app 14:37:25) and by all official-source Asr comparisons
(±1m PASS). The observed offset originates entirely from the secondary
Aladhan reference: minute truncation plus a low-sun divergence that grows
as solar altitude drops (−12s at 32° ⇐ −241s at ~11°), with reference
values observed to shift between fetches (Tromsø 10-07: 14:43→14:41).
Reproducible Tromsø delta is −4m, inside the ±5m high-latitude margin.
No code change; no CR-0012. Full evidence: `docs/od-0028-asr-investigation.md`
(re-open if an official — not secondary — source contradicts by >2m).

**Resolution required before:** Any change to Asr calculation behavior for
**Resolution required before:** Any change to Asr calculation behavior for
high latitudes.

## OD-0029 — Device substitution for Task 6 testing

**Status:** DECIDED — Option A (2026-10-09)
**Blocking Phase:** Phase 02 (Task 6)
**Type:** Device / testing
**Priority:** High

**Question:**
هل نستخدم Oppo A95 (CPH2365, Android 13) بدل Pixel 6a / Redmi Note 12؟

**Context:**
- DEC-0017: Pixel 6a (primary) + Redmi Note 12 (secondary).
- **لا يُوجد أي منهما** حالياً.
- Oppo A95 متصل ويعمل (`db692b78`, Android 13 / API 33).

**Options:**
- A: Oppo A95 للـ Task 6 + Pixel 6a لـ performance testing (Phase 09+).
- B: انتظر Pixel 6a → تأجيل Task 6.
- C: اختبار على محاكي (مرفوض — نسبة كبيرة من الاختبارات لا تعمل عليه).

**Decision:** A — Oppo A95 لتنفيذ اختبارات Task 6.

**Reason:**
- اختبارات Task 6 = logic + UI + permissions — لا حساسية لطراز الجهاز.
- Pixel 6a يهم لـ cold start / memory (Phase 09+)؛ أداء البداية الباردة
  يُقاس على الجهاز المرجعي لاحقاً وفق DEC-0017 دون تغيير.

**Caveat (ColorOS قد يخالف Stock Android في):**
- Permission prompts
- Battery optimization
- Notifications (لا مهمة في Task 6)

**Affected Documents:** `NEXT_SESSION.md`, `docs/phase-02-device-testing.md`,
`phases/02.md` (Deviations).

## OD-0030 — Tafsir Source Rights

**Status:** OPEN
**Blocking Phase:** 06b (deferred to v1.5)
**Date:** 2026-10-17

**Question:** ما مصدر نصوص التفاسير التراثية (ابن كثير، البغوي، الطبري)
بحقوق إعادة نشر مثبتة؟

**Context:**
- shamela.ws: حقوق محفوظة (لا إعادة نشر).
  Evidence: `https://shamela.ws/page/terms` — "تبقى الحقوق في الكتب
  والطبعات والمواد لأصحابها ... لا تمنحك هذه الشروط حقًا في إعادة
  استخدام المحتوى خارج ما يسمح به النظام أو إذن صاحب الحق."
- النسخ الثلاث محققة حديثاً (ليست نصاً عارياً):
  - ابن كثير (ت 774هـ): `https://shamela.ws/book/8473` — تحقيق سامي
    السلامة، دار طيبة، ط2 1420هـ/1999م.
  - البغوي (ت 510هـ): `https://shamela.ws/book/41` — تحقيق
    النمر/ضميرية/الحرش، دار طيبة، ط4 1417هـ/1997م.
  - الطبري (ت 310هـ): `https://shamela.ws/book/43` — مشتقة من تحقيق
    محمود شاكر + طبعة الحلبي.
- archive.org: يحتاج تحقق.
- المراسلة: 2-6 أشهر (يتجاوز نافذة v1.0).

**Options:**
- A: مصدر PD قديم (قبل 1929م) — بحاجة للبحث.
- B: مراسلة دار طيبة (2-6 أشهر).
- C: تفسير واحد (ابن كثير) بعد مراسلة.
- D: إسقاط لـv1.5 (الحالي).

**Decision:** D — مؤجل لـv1.5 (CR-0017، 2026-10-17).

high latitudes.