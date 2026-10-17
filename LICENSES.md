# LICENSES — دليل المسلم

> المصدر: `03-decisions.md` (DEC-0014 … DEC-0018). حزمة غير مدرجة هنا = **BLOCK** (`security/02-dependencies.md`).
> تاريخ التحقق: **2026-10-05** (و2026-10-06 لبعض بنود SDK).
> سجل التبعيات المفصّل: `security/02-dependencies.md` + `pubspec.lock` (مُلتزم به).

## 1. ترخيص التطبيق

- **MIT** — الكود المكتوب في هذا المستودع (`lib/`, `test/`, `tool/`, `android/`, سكربتات CI).
- القرار: DEC-0014 (2026-10-05، حسم OD-0001).

## 2. الأدوات / SDK (طُوّرت به، لا تُشحن كحزم)

| المكوّن | الإصدار | الترخيص | الدليل |
|---|---|---|---|
| Flutter SDK | 3.47.5 (stable) | BSD-style (BSD-3-Clause text) | `C:\src\flutter\LICENSE` — "Redistribution and use in source and binary forms…" (قرأ 2026-10-06) |
| Dart SDK | 3.13.4 | BSD-style (BSD-3-Clause text) | `C:\src\flutter\bin\cache\dart-sdk\LICENSE` (قرأ 2026-10-06) |

## 3. حزم مباشرة (pubspec.yaml)

| الحزمة | الإصدار | السبب (DEC) | الترخيص | أداة التحقق |
|---|---|---|---|---|
| audio_service | 0.18.19 (exact) | خدمة تشغيل الصوت بالخلفية — CR-0012 | MIT (+ Apache-2.0 ExoPlayer) | CR-0012 + LICENSE — https://pub.dev/packages/audio_service/versions/0.18.19 |
| audio_session | 0.2.4 (exact) | إعداد AudioSession ومراقبة المقاطعات (Task 6) — CR-0014 | MIT | pub.dev API 2026-10-11 (نُشر 2026-06-29T13:10:31.881382Z) — https://pub.dev/packages/audio_session/versions/0.2.4 |
| flutter_local_notifications | 22.3.1 (exact) | الإشعارات المحلية المجدولة — CR-0012 | BSD-3-Clause | أرشيف pub.dev LICENSE — https://pub.dev/packages/flutter_local_notifications/versions/22.3.1 |
| flutter_riverpod | 2.6.1 (exact) | إدارة الحالة — DEC-0002، DEC-0016 | MIT | pub.dev صفحة الإصدار + API — https://pub.dev/packages/flutter_riverpod/versions/2.6.1 |
| flutter_localizations | Flutter SDK | الترجمة وتهيئة ARB | BSD-style (BSD-3-Clause text) | Flutter SDK |
| go_router | 18.0.2 (exact) | التنقل — DEC-0003 | BSD-3-Clause | pub.dev — https://pub.dev/packages/go_router/versions/18.0.2 (نُشر 2026-09-28؛ تحقق 2026-10-07) |
| hive_ce | 2.20.2 (exact) | تخزين الإعدادات والبيانات المحلية — DEC-0024، DEC-0027 | BSD-3-Clause (+ Apache-2.0 لجزء مدمج) | pub.dev — https://pub.dev/packages/hive_ce/versions/2.20.2 |
| hive_ce_flutter | 2.4.0 (exact) | تهيئة Hive لتطبيق Flutter | BSD-3-Clause؛ يتضمن أجزاء أقدم بترخيص Apache-2.0 | pub.dev — https://pub.dev/packages/hive_ce_flutter/versions/2.4.0 |
| intl | 0.20.3 (exact) | تنسيق الأرقام حسب اللغة — DEC-0026 | BSD-3-Clause | pub.dev — https://pub.dev/packages/intl/versions/0.20.3 |
| just_audio | 0.10.6 (exact) | تشغيل صوت الأذان — CR-0012 | MIT (+ Apache-2.0 ExoPlayer) | CR-0012 + LICENSE — https://pub.dev/packages/just_audio/versions/0.10.6 |
| path_provider | 2.1.6 (exact) | مسارات Hive وسجل الأخطاء — CR-0006 | BSD-3-Clause | pub.dev — https://pub.dev/packages/path_provider/versions/2.1.6 |
| share_plus | 13.3.1 (exact) | تصدير سجل الأخطاء عبر مشاركة النظام — DEC-0025 | BSD-3-Clause | pub.dev — https://pub.dev/packages/share_plus/versions/13.3.1 |
| timezone | 0.11.1 (exact) | قاعدة المناطق الزمنية لتهيئة Phase 01 والإشعارات — CR-0008، CR-0012 | BSD-2-Clause | pub.dev — https://pub.dev/packages/timezone/versions/0.11.1 (نُشر 2026-06-29؛ تحقق 2026-10-07) |
| geolocator | 14.1.1 (exact) | خدمة الموقع (GPS + fallback) — CR-0009 | MIT | pub.dev — https://pub.dev/packages/geolocator/versions/14.1.1 |
| flutter_compass | 0.8.1 (exact) | بوصلة القبلة (Qibla heading) — CR-0011 | MIT | pub.dev — https://pub.dev/packages/flutter_compass/versions/0.8.1 (نُشر 2024-11-17، latest؛ تحقق 2026-10-09) |
| hijri | 3.0.1 (exact) | التقويم الهجري (Umm al-Qura) — DEC-0033، CR-0019 | BSD-2-Clause | pub.dev — https://pub.dev/packages/hijri/versions/3.0.1 (تحقق 2026-10-17) |
| geolocator_platform_interface | 4.4.0 (exact, dev) | Fake platform في اختبارات Location Service | BSD-3-Clause | pub.dev — https://pub.dev/packages/geolocator_platform_interface/versions/4.4.0 |
| very_good_analysis | 11.0.0 (exact, dev) | قواعد التحليل الساكن — DEC-0011 | MIT | pub.dev — https://pub.dev/packages/very_good_analysis |

## 4. تبعيات `pubspec.lock` (كلها — غير مباشرة)

أُكدت من ملف `LICENSE` داخل أرشيف كل حزمة على `https://pub.dev/api/archives/<p>-<v>.tar.gz` (توقيع النص: BSD-text / Apache-2.0 text / MIT text)، إلا ما أُكّد من صفحة pub.dev مباشرة:

| الحزمة | الإصدار | الترخيص | التحقق |
|---|---|---|---|
| async | 2.13.1 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| boolean_selector | 2.1.2 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| characters | 1.4.1 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| clock | 1.1.3 | Apache-2.0 | أرشيف LICENSE — "Apache License Version 2.0" (2026-10-06) |
| collection | 1.19.1 | BSD-3-Clause | pub.dev (2026-10-05) |
| fake_async | 1.3.3 | Apache-2.0 | أرشيف LICENSE — "Apache License Version 2.0" (2026-10-06) |
| leak_tracker | 11.0.2 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| leak_tracker_flutter_testing | 3.0.10 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| leak_tracker_testing | 3.0.2 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| matcher | 0.12.20 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| material_color_utilities | 0.13.0 | Apache-2.0 | أرشيف LICENSE — "Apache License Version 2.0" (2026-10-06) |
| meta | 1.18.3 | BSD-3-Clause | pub.dev (2026-10-05) |
| path | 1.9.1 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| riverpod | 2.6.1 | MIT | pub.dev (2026-10-05) |
| source_span | 1.10.2 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| stack_trace | 1.12.2 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| state_notifier | 1.0.0 | MIT | pub.dev (2026-10-05) |
| stream_channel | 2.1.4 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| string_scanner | 1.4.1 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| term_glyph | 1.2.2 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| test_api | 0.7.12 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| vector_math | 2.4.0 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |
| vm_service | 15.3.0 | BSD-3-Clause | أرشيف LICENSE (2026-10-06) |

حزم من المصدر `sdk` (جزء من Flutter SDK — انظر §2): `flutter`، `flutter_test`، `sky_engine`.

سلامة النسخ: sha256 لكل حزمة مسجّل في `pubspec.lock` (يتحقق منه `flutter pub get --enforce-lockfile` في CI).

## 5. الأصول (محتوى/خطوط/صور)

- لم تكن هناك أصول مُشحونة في Phase 00. أصول Phase 06 موثقة أدناه وفي `legal/assets.yaml`.

### Tanzil Quran Text

- Version: Uthmani 1.1 (2021-02).
- License: Creative Commons Attribution 3.0; changing the Quran text is not allowed.
- Use: Tanzil's developer FAQ says its resources are for non-commercial purposes. The application is free with no monetization per `00-project-charter.md`.
- Required attribution: “Tanzil Quran Text — Copyright (C) 2007-2026 Tanzil Project — License: Creative Commons Attribution 3.0”, with a link to https://tanzil.net.
- Copyright notice discrepancy: the downloaded text embeds 2007-2026, while the license page displays 2007-2021. Both source snapshots are retained under `legal/evidence/`.

### Amiri Quran Font

- Version: 1.003; published 2025-06-13 — https://github.com/aliftype/amiri/releases/tag/1.003
- License: SIL Open Font License 1.1 — https://openfontlicense.org/
- The font may be bundled and redistributed with software, but not sold by itself. Modifications are permitted under OFL terms, including its Reserved Font Name conditions.
- Include the copyright notice and OFL with each distributed font copy; the license snapshot is `legal/evidence/amiri-ofl-2026-10-16.txt`.
- سجل الأصول الكامل: `legal/assets.yaml` (يُحدَّث إلى schema v2 قبل تفعيل CI-001/003–008 — DEC-0018).

## 6. حزم حُذفت من قالب `flutter create` (غير مدرجة في أي DEC)

- `cupertino_icons` — لا استخدام لها ولا قرار بـها.
- `flutter_lints` — استُبدلت بـ `very_good_analysis` (DEC-0011).

## 7. حزم Spike (Phase 00B)

حزم CR-0012 أدناه اختُبرت في Spike ثم اعتُمدت كحزم مباشرة؛ السجل القانوني
المعتمد موجود في §3. تفاصيل الاختبار موثّقة في `spike/README.md`.

| الحزمة | الإصدار | الترخيص | التحقق |
|---|---|---|---|
| حزم CR-0012 الأربع | exact pins | كما في §3 | Spike `spike/RESULTS.md`؛ CR-0012 |

## 8. ملاحظات

- توليد `THIRD_PARTY_NOTICES` الكامل عند الإصدار (ci/01 — On main، Phase 09).
- لا حزمة شبكة (لا `http`/`dio`/…) — الشبكة ممنوعة حتى Phase 07 (Rule 008).
