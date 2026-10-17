# AI Development Rules

You are an implementation agent working under MASTER_SPEC.

## Mandatory (قبل تغيير الكود)

1. اقرأ `README.md`.
2. اقرأ `00-project-charter.md`.
3. اقرأ المتطلبات ذات الصلة.
4. اقرأ القرارات ذات الصلة.
5. اقرأ القرارات المفتوحة.
6. اقرأ التعارضات والفجوات.
7. اقرأ المعمارية ذات الصلة.
8. اقرأ مواصفة المرحلة.

## Never

- اختراع متطلبات.
- اختراع تراخيص.
- اختراع مصادر.
- اختيار قرار معماري غير محسوم بصمت.
- تجاوز CI.
- تعديل ملفات خارج النطاق.
- وضع "منجز" بلا دليل.
- ادعاء نجاح الاختبارات بلا ناتج.
- ادعاء نجاح البناء بلا ناتج.
- بدء مرحلة مقفلة.

## Stop Rules

```
1.  احتجت محتوى شرعيًا غير موجود في Assets المعتمدة؟       توقف واطلب المصدر.
2.  احتجت تعديل Phase سابقة؟                                 توقف واطلب CR.
3.  تعارض بين مصدرين؟                                        توقف واطلب قرارًا.
4.  مكتبة بلا ترخيص واضح؟                                    توقف واطلب قرارًا.
5.  الحل يتطلب شبكة خارج مسار التلاوة؟                      توقف واطلب موافقة.
6.  ستخزن محتوى ثابتًا في DB المستخدم؟                      توقف واطلب مراجعة.
7.  احتجت كتابة نص قرآني/حديث/دعاء من الذاكرة؟               توقف فورًا. ممنوع.
8.  Schema غير مفهوم؟                                        توقف واسأل.
9.  انكسر اختبار سابق؟                                       توقف. لا تتجاوزه.
10. عجزت عن تحقيق معيار قبول قابل للقياس؟                   توقف واشرح السبب.
11. إصدار حزمة لا تستطيع التحقق منه؟                         سجّله "غير متحقق" واسأل.
12. احتجت صلاحية جديدة في Android/iOS؟                       توقف واطلب موافقة.
13. احتجت تغيير typeId أو شكل بيانات مخزنة؟                  توقف واطلب migration.
14. تحذير analyze لا تستطيع إصلاحه؟                          توقف. لا تكتمه.
15. احتجت حزمة غير مدرجة في DECISIONS؟                        توقف واطلب إضافتها.
16. الخطوة تتجاوز نطاق المرحلة؟                              توقف واذكر ما خرج.
17. لم تستطع تشغيل الأوامر؟                                  قل ذلك صراحة.
```

## Content Review Rule

- لا تعتمد محتوى دينيًا بنفسك.
- المحتوى الشرعي يحتاج مراجعًا بشريًا موثقًا في `content/reviewers.yaml`.
- المسار: `content/08-review-workflow.md` (HTML + JSON).
- أي pack بحالة `pending` = ممنوع في production.

## If Ambiguous

توقف. أبلغ عن:

- الالتباس
- الوثائق المتأثرة
- الخيارات الممكنة
- القرار المطلوب

لا تخمّن.

## Completion Rule

لا تقل "منجز" إلا إذا نُفذ التحقق فعليًا.
الدليل يشمل: الأمر، النتيجة، المخرجات، الحالة.

## Git discipline

- **Never amend pushed commits.**
  - إن اكتُشف amend على commit مدفوع → `git reset --hard origin/main` + forward commit جديد. لا force-push.
- **Pre-push review:**
  - قبل كل push: `git log --oneline -5` + `git status`.
  - تأكد main HEAD صحيح + الشجرة نظيفة.
- **Pre-push checklist:**
  - [ ] analyze --fatal-infos = 0 issues
  - [ ] flutter test = all pass
  - [ ] flutter build apk --debug = Built
  - [ ] No `*.txt` debug files
  - [ ] No amended commits

## CI — Flutter on GitHub Actions

- **Free disk space step إلزامي:**
  - Flutter projects with native plugins (share_plus, geolocator, flutter_compass) قد تنفد من مساحة runner (14 GB).
  - أضف step: `Free disk space` (NDK, dotnet, ghc, emulator, system-images).
- **NEVER `rm -rf "$AGENT_TOOLSDIRECTORY"`** — Flutter lives there. (Phase 04 lesson, CI #90)
- **Cache Gradle:** `~/.gradle/caches` + `~/.gradle/wrapper`.
- **Symptom of low disk:** `No space left on device` during `packageDebug`, or Gradle cache write failures.

## Test/Production coupling

- NEVER commit a test that asserts on production code not yet committed.
- Rule: tests + production changes in the SAME commit.
- Violation: CI will fail on the test-only commit (c188955, 2026-10-13).
- Always run `git status` + `git show origin/main:<file>` before assuming a test is valid.

## Widget test — layout coupling

- Test each section in isolation where possible: "shows X section" → scroll to X → assert X.
- Avoid "shows all N sections" mega-tests — fragile against layout changes.
- When mega-test required: sequence stages (top → scroll → mid → scroll → bottom).
- Never assume a section is "top" — viewport depends on prior sections' height.
- Use `tester.scrollUntilVisible(target, 400)` (no `scrollable:` parameter) — never `drag(fixedPixels)`.
- GAP-widget-test-layout-coupling registered (refactor to section-specific tests in Phase 06).

## Religious content collection — Phase 07 lessons

- **Digital sources are scarce:** no single complete 304-entry source with grades exists.
- **External verification blocked:** dorar.net and sunnah.com return HTTP 403 to automation.
- **Complex packages need CR:** `dorar_hadith` pulls drift (blocked by OD-0002 until Phase 12).
- **v1.0 (7 adhkar) was pragmatic:** verified content, no licensing risk.
- **Expansion deferred to Phase 09+:** needs a separate source-resolution CR.
- **382 was an estimation error:** actual file content is 304 entries (verified by parse, then frozen).
- **Phase numbering is reserved:** Phase 08 = Hijri calendar (completed); new azkar work uses 05b/05c suffixes — never overwrite an existing phase file.

## Related

- `governance/00-change-control.md`
- `content/reviewers.yaml`
- `content/08-review-workflow.md`
