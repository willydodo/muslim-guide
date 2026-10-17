# UI Vision — دليل المسلم

> **النوع:** رؤية تصميمية بعيدة المدى (لا تُنفَّذ دفعة واحدة).
> **الحالة:** VISION — مرجع للتصميم النهائي.
> **التنفيذ:** مرحلي وفق `phases/NN.md`.
> **آخر تحديث:** 2026-10-07

---

## 0. القواعد الحاكمة

هذه الوثيقة تلتزم بـ:

* `00-integrity-rules.md` (خصوصاً Rules 007, 009, 011)
* `content/00-content-policy.md` (لا نصوص دينية من الذاكرة)
* `architecture/07-localization.md` (ARB فقط، لا نصوص مضمّنة)
* `product/05-accessibility.md` (وصولية كاملة)
* `legal/00-licensing-policy.md` (كل أصل له ترخيص)
* `03-decisions.md` (DEC-0024 → DEC-0027)

### ⛔ ممنوعات صارمة

1. **لا نص قرآني/حديث/دعاء حرفي** — يُستخدم `[PLACEHOLDER-AYAH-XXX]`
2. **لا نص عربي مضمّن في الكود** — ARB keys فقط
3. **لا صورة بلا ترخيص** — كل صورة في `legal/assets.yaml`
4. **لا provider بلا تحديد** — `autoDispose` أم `keepAlive`
5. **لا شاشة بلا 5 حالات** — Loading / Empty / Error / Success / Refreshing

---

## 1. المبادئ التصميمية

### 1.1 الرؤية

* **Live Dashboard** بدل شبكة أيقونات ثابتة
* **بيانات حقيقية** بدل عناصر جامدة
* **تفاعل هادف** بدل تزيين
* **بساطة إسلامية** — لا زخرفة مفرطة

### 1.2 Design Tokens

* `AppColors.*` — لا ألوان صريحة
* `AppSpacing.*` — لا أرقام صريحة
* `AppTypography.*` — من Material 3
* `AppStrings.of(context, 'key')` — ARB keys فقط

### 1.3 اللغات والاتجاه

* **AR (افتراضي)** + **EN**
* **RTL** للعربية، **LTR** للإنجليزية
* **النص القرآني:** RTL ثابت بغض النظر عن لغة الواجهة
* **الأرقام:** Latin في الواجهة، Arabic-Indic للنص القرآني (DEC-0026)

### 1.4 الوصولية (إلزامي)

* Touch targets ≥ 48dp
* Text scale حتى 200% بلا قص
* Semantic labels لكل عنصر تفاعلي
* تباين AA (4.5:1) على الأقل
* دعم TalkBack / VoiceOver

### 1.5 Offline First

* كل شاشة تعمل بلا شبكة
* البيانات المحلية أولاً
* الشبكة فقط في Phase 07 (التلاوة)

---

## 2. هيكل الرئيسية (Live Dashboard)

### 2.1 الفكرة

لوحة حية بكروت تفاعلية تعرض بيانات المستخدم — بديلاً عن شبكة أيقونات ثابتة.

### 2.2 الترتيب من الأعلى للأسفل

```text
┌─────────────────────────────────────┐
│ AppTopBar: "home\_greeting" + Avatar │
├─────────────────────────────────────┤
│ 🎴 NextPrayerCard                   │
│   - Live countdown                  │
│   - CTA: "view\_all\_prayer\_times"    │
├─────────────────────────────────────┤
│ 📚 LastReadCard (conditional)       │
│   - "continue\_reading"              │
│   - Progress bar + Surah/Ayah       │
├─────────────────────────────────────┤
│ 📿 TodayAzkarCard                   │
│   - Circular progress               │
│   - "3 / 12"                        │
├─────────────────────────────────────┤
│ 🗓️ HijriDateCard                    │
│   - Hijri date + next event         │
├─────────────────────────────────────┤
│ 📊 WeeklyStatsCard                  │
│   - Neutral stats (no gamification) │
├─────────────────────────────────────┤
│ ⭐ FavoritesRow                     │
│   - 4 favorites + "more"            │
└─────────────────────────────────────┘
```

### 2.3 الكروت التفاعلية — التفاصيل

#### 🎴 الكارت 1: NextPrayerCard

|الخاصية|التفاصيل|
|-|-|
|**ARB Keys**|`home_next_prayer_title`, `home_prayer_remaining`, `view_all_prayer_times`|
|**البيانات**|Countdown, Prayer name, Time, Hijri date|
|**المصدر**|`nextPrayerProvider` (Stream, autoDispose)|
|**الحالات**|Loading / Success / Error (لا موقع) / Empty (لا مواقيت)|
|**التفاعل**|Tap → Prayer Times · Long press → Menu|
|**الحركة**|Pulse عند < 5 دقائق · Gradient حسب الصلاة|
|**الوصولية**|Semantic: "الصلاة القادمة: العصر بعد 2 ساعة و 15 دقيقة"|
|**Offline**|✅ يعمل بالكامل (مواقيت محسوبة محلياً)|

#### 📚 الكارت 2: LastReadCard

|الخاصية|التفاصيل|
|-|-|
|**ARB Keys**|`home_last_read_title`, `continue_reading`, `home_no_reading_yet`, `start_reading`|
|**البيانات**|Surah, Ayah, Progress %|
|**المصدر**|`lastReadProvider` (Notifier, keepAlive)|
|**الحالات**|Loading / Empty (لم يقرأ بعد) / Success / Error|
|**التفاعل**|Tap → Quran at last position · Long press → Change|
|**الوصولية**|Semantic: "آخر قراءة: سورة البقرة، الآية 45"|
|**Offline**|✅ يعمل (الموضع محفوظ محلياً)|

#### 📿 الكارت 3: TodayAzkarCard

|الخاصية|التفاصيل|
|-|-|
|**ARB Keys**|`home_azkar_title`, `home_azkar_progress`, `home_azkar_morning`, `home_azkar_evening`, `home_azkar_complete`|
|**البيانات**|Completed, Total, Period (صباح/مساء)|
|**المصدر**|`todayAzkarProvider` (AsyncNotifier, autoDispose)|
|**الحالات**|Loading / Empty (لا تقدم) / Success / Complete|
|**التفاعل**|Tap → Azkar screen|
|**الوصولية**|Semantic: "أذكار الصباح: 3 من 12"|
|**Offline**|✅ يعمل (المحتوى asset)|

#### 🗓️ الكارت 4: HijriDateCard

|الخاصية|التفاصيل|
|-|-|
|**ARB Keys**|`home_hijri_date`, `home_next_event`, `home_days_remaining`|
|**البيانات**|Hijri date, Next event, Countdown|
|**المصدر**|`hijriDateProvider` (Notifier, autoDispose)|
|**الحالات**|Loading / Success / Error|
|**التفاعل**|Tap → Hijri Calendar|
|**الحركة**|تحديث عند منتصف الليل (Timer + AnimatedSwitcher)|
|**الوصولية**|Semantic: "التاريخ الهجري: 5 ربيع الأول"|
|**Offline**|✅ يعمل (حساب محلي وفق OD-0005)|

#### 📊 الكارت 5: WeeklyStatsCard

|الخاصية|التفاصيل|
|-|-|
|**ARB Keys**|`home_weekly_stats`, `home_weekly_prayers`, `home_weekly_azkar`, `home_weekly_quran`|
|**البيانات**|Neutral stats (لا أهداف، لا streaks)|
|**المصدر**|`weeklyStatsProvider` (AsyncNotifier, keepAlive)|
|**الحالات**|Loading / Empty / Success|
|**التفاعل**|Tap → Stats screen|
|**⚠️ Gamification**|لا أهداف، لا مكافآت، لا مقارنات، لا "يجب أن"|
|**الوصولية**|Semantic: "إحصاءات هذا الأسبوع: 30 صلاة، 45 ذكر، 5 صفحات"|
|**Offline**|✅ يعمل (بيانات محلية)|

### 2.4 الميزات التفاعلية

|الميزة|التنفيذ|ملاحظة|
|-|-|-|
|**Drag-to-Reorder**|`ReorderableSliverList` **فقط** في "وضع التحرير" (زر AppBar)|يمنع تعارض الإيماءات|
|**Hide/Show Cards**|من الإعدادات → `home_visible_cards`|يُحفظ في Hive|
|**Live Countdown**|`Timer.periodic(1s)` **فقط** عند `AppLifecycleState.resumed`|يُلغى عند background (توفير بطارية)|
|**Pull-to-Refresh**|`RefreshIndicator` — **معطّل** في وضع التحرير|لا تعارض|
|**Haptic Feedback**|`HapticFeedback.lightImpact()` عند اكتمال ذكر|`SystemCapabilities` check|

---

## 3. وصفات الشاشات (Widget Recipes)

### 🎴 وصفة 1: SplashScreen

**الهدف:** تهيئة التطبيق (Hive، l10n، timezone) — لا تأخير اصطناعي.

**المدة:** حتى اكتمال التهيئة (عادة < 500ms). إن < 300ms → cross-fade مباشر بلا عرض Splash.

**الخلفية:** `assets/images/splash_bg.webp` (أصل معتمد — انظر §4).

**الحالة:**

* `bootstrapProvider` (AsyncNotifier, autoDispose) — يهيّئ Hive + l10n + error log

**شجرة الويدجتات:**

```text
Scaffold
  Stack
    Image.asset('assets/images/splash\_bg.webp', fit: cover)
    Container (gradient overlay: AppColors.heroScrimVertical)
    Column (center)
      Image.asset('assets/images/app\_logo\_mark.png', width: 120)
      Text(AppStrings.of(context, 'app\_name'), style: displayLarge)
      Text(AppStrings.of(context, 'app\_tagline'), style: bodyMedium)
```

**ARB Keys:** `app_name`, `app_tagline`

**الحالات:**

* **Loading:** عرض Splash
* **Success:** → `goToNext()` (Language Selection أو Home)
* **Error:** عرض خطأ + زر "إعادة المحاولة"

**التفاعل:**

* `goToNext()`:

  * إن `!onboarding_completed` → `/onboarding/language`
  * إن `onboarding_completed` → `/home`

**ملاحظات:**

* لا شبكة.
* إن فشل تحميل الصورة → fallback إلى `IslamicSceneBanner` (رسم برمجي).
* لا تأخير ثابت (لا `Future.delayed(2s)`).

---

### 🎴 وصفة 2: LanguageSelectionScreen (Onboarding)

**الهدف:** اختيار اللغة عند أول تشغيل (DEC-0006 — إلزامي).

**الخلفية:** gradient خفيف.

**الحالة:**

* `settingsRepository.language` (Notifier, autoDispose)

**شجرة الويدجتات:**

```text
Scaffold
  Padding
    Column
      Text(AppStrings.of(context, 'onboarding\_choose\_language'), style: headlineLarge)
      SizedBox
      LanguageCard(language: 'ar', label: 'العربية', nativeLabel: true)
      LanguageCard(language: 'en', label: 'English', nativeLabel: true)
      Spacer
      PrimaryButton(
        text: AppStrings.of(context, 'onboarding\_continue'),
        onPressed: selectedLanguage != null ? onContinue : null,
      )
```

**ARB Keys:** `onboarding_choose_language`, `onboarding_continue`, `language_arabic`, `language_english`

**الحالات:**

* **Loading:** (لا يوجد — البيانات محلية)
* **Success:** تفاعل طبيعي
* **Error:** (لا يوجد)

**الأحداث:**

* `onContinue(lang)`:

  * `settingsRepository.setLanguage(lang)`
  * `→ /onboarding/welcome`

**الوصولية:**

* Touch targets ≥ 48dp
* Semantic لكل بطاقة: "اختر اللغة العربية"
* Focus order: بطاقة 1 → بطاقة 2 → زر المتابعة

**Offline:** ✅

---

### 🎴 وصفة 3: HomeScreen

**الهدف:** Live Dashboard بكروت تفاعلية.

**الخلفية:** gradient خفيف `AppColors.primaryGradient` في الأعلى فقط.

**الحالة (Riverpod):**

* `nextPrayerProvider` (Stream, autoDispose)
* `lastReadProvider` (Notifier, keepAlive)
* `todayAzkarProvider` (AsyncNotifier, autoDispose)
* `hijriDateProvider` (Notifier, autoDispose)
* `weeklyStatsProvider` (AsyncNotifier, keepAlive)
* `favoritesProvider` (AsyncNotifier, keepAlive)
* `homeCardOrderProvider` (Notifier, keepAlive)

**شجرة الويدجتات:**

```text
Scaffold
  appBar: AppTopBar(
    title: AppStrings.of(context, 'home\_greeting'),
    actions: \[Avatar],
  )
  body: RefreshIndicator
    CustomScrollView
      SliverToBoxAdapter: NextPrayerCard
      SliverToBoxAdapter: LastReadCard (conditional)
      SliverToBoxAdapter: TodayAzkarCard
      SliverToBoxAdapter: HijriDateCard
      SliverToBoxAdapter: WeeklyStatsCard
      SliverToBoxAdapter: SectionHeader(AppStrings.of(context, 'home\_favorites'))
      SliverToBoxAdapter: FavoritesRow
      SliverToBoxAdapter: SectionHeader(AppStrings.of(context, 'home\_quick\_access'))
      SliverToBoxAdapter: QuickAccessGrid
```

**ARB Keys:** `home_greeting`, `home_favorites`, `home_quick_access`، وكل مفاتيح الكروت

**الحالات:**

* **Loading:** Skeleton للكروت (Shimmer)
* **Empty:** إن لا بيانات → كروت "دعوة" (ادعُ المستخدم للبدء)
* **Error:** بطاقة خطأ + زر "إعادة المحاولة"
* **Success:** عرض طبيعي
* **Refreshing:** RefreshIndicator

**الأحداث:**

* `onCardTap(cardId)` → فتح الشاشة
* `onCardLongPress(cardId)` → وضع التحرير
* `onPullRefresh` → تحديث المزوّدات

**الوصولية:**

* كل كارت له Semantic label شامل
* Focus order: TopBar → Cards (top to bottom) → Favorites → Quick Access
* Reduced motion: تعطيل animations

**Offline:** ✅ (كل شيء محلي)

---

### 🎴 وصفة 4: PrayerTimesScreen

**الهدف:** عرض المواقيت الخمس + الشروق + عدّاد.

**الخلفية:** `assets/images/prayer_hero_haram.webp` (أصل معتمد — §4).

**الحالة:**

* `prayerTimesProvider` (AsyncNotifier, autoDispose)
* `locationProvider` (Notifier, keepAlive)
* `calculationMethodProvider` (Notifier, keepAlive)

**شجرة الويدجتات:**

```text
Scaffold (بلا AppBar — صورة full-bleed)
  Column
    PrayerHeroCard
      Image.asset('assets/images/prayer\_hero\_haram.webp')
      Column
        Text(city\_name)
        CountdownTimer
        Row: \[MenuButton, SettingsButton]
    Expanded → ListView
      PrayerTimeRow × 5 (Fajr, Dhuhr, Asr, Maghrib, Isha)
      SunriseRow (بملاحظة "sunrise\_not\_prayer")
      NotificationSettingsButton
```

**ARB Keys:** `prayer_fajr`, `prayer_dhuhr`, `prayer_asr`, `prayer_maghrib`, `prayer_isha`, `sunrise_not_prayer`, `prayer_notification_settings`

**الحالات:**

* **Loading:** Skeleton rows
* **Empty:** "لم يتم تحديد الموقع" + زر الإعدادات
* **Error:** "فشل الحساب" + إعادة المحاولة
* **Success:** عرض طبيعي
* **Refreshing:** Pull-to-refresh

**الحالات الفلكية غير المتاحة:**

* إذا كانت الصلاة أو ظاهرة الشروق/الغروب غير قابلة للحساب فلكياً، لا يُعرض
  وقت بديل من يوم أو مدينة أخرى؛ يُعرض أنها غير متاحة بمفتاح ترجمة مستقل.
* تُعرض الأوقات الأخرى القابلة للحساب، مثل الظهر والعصر، كالمعتاد.
* لا تُطبّق بدائل خطوط العرض العالية على يوم قطبي لا تتوفر فيه ظاهرتا الشروق
  والغروب؛ اختيار بديل غير فلكي مؤجل إلى OD-0027.

**الأحداث:**

* `onPrayerTap(prayer)` → تفعيل/إلغاء إشعار
* `onMenuPressed` → Drawer
* `onSettingsPressed` → Settings

**الوصولية:**

* Semantic لكل صف: "الفجر: 5:15 صباحاً"
* Touch targets 48dp

**Offline:** ✅ (حساب محلي)

**مرجع:** REQ-PRAYER-001, OD-0011

---

### 🎴 وصفة 5: QiblaScreen

**الهدف:** بوصلة تفاعلية للقبلة.

**الخلفية:** `CustomPainter` (بوصلة) + `assets/images/qibla_bg.webp` (أصل معتمد — §4).

**الحالة:**

* `qiblaDirectionProvider` (Notifier, autoDispose)
* `compassProvider` (Stream, autoDispose)
* `sensorStatusProvider` (Notifier, autoDispose)

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(title: AppStrings.of(context, 'qibla\_title'))
  body: Stack
    Image.asset('assets/images/qibla\_bg.webp') + overlay
    Column
      QiblaCompass (CustomPainter)
        Image.asset('assets/images/kaaba\_badge.webp') // center
        Arrow (green) pointing to qibla
      Text('${direction}°', style: displayLarge)
      Text(AppStrings.of(context, 'qibla\_direction\_label'))
      AppCard
        Row: \[Icon(location), Text(city\_name)]
      PrimaryButton(text: AppStrings.of(context, 'qibla\_calibrate'))
```

**ARB Keys:** `qibla_title`, `qibla_direction_label`, `qibla_calibrate`, `qibla_no_sensor`, `qibla_calibrating`

**الحالات:**

* **Loading:** "جاري قراءة الحساس"
* **Empty:** (لا يوجد — دائمًا اتجاه)
* **Error:** "لا يوجد حساس مغناطيسي" + بديل رقمي
* **Success:** عرض طبيعي
* **Calibrating:** "حرّك الجهاز على شكل ∞"

**الأحداث:**

* `onCalibrate` → معايرة

**الوصولية:**

* Semantic: "اتجاه القبلة: 135 درجة جنوب شرق"
* بديل نصي كامل بلا اعتماد على البوصلة

**Offline:** ✅ (حساب محلي)

**مرجع:** REQ-QIBLA-001

---

### 🎴 وصفة 6: QuranScreen

**الهدف:** فهرس السور + متابعة القراءة.

**الخلفية:** gradient + (اختياري) `assets/images/quran_book.webp`.

**الحالة:**

* `quranIndexProvider` (AsyncNotifier, keepAlive) — الفهرس فقط
* `lastReadProvider` (Notifier, keepAlive)
* `downloadedSurahsProvider` (AsyncNotifier, keepAlive)
* `reciterProvider` (Notifier, keepAlive)

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(
    title: AppStrings.of(context, 'quran\_title'),
    actions: \[SearchButton],
  )
  body: CustomScrollView
    SliverToBoxAdapter: QuranHeaderCard
      Image.asset('assets/images/quran\_book.webp', width: 80)
      Text(AppStrings.of(context, 'quran\_subtitle'))
      Row: \[PrimaryButton('continue\_reading'), OutlinedButton('listen')]
    SliverToBoxAdapter: LastReadMiniCard (conditional)
    SliverList: SurahListItem × 114
      CircleAvatar(number)
      Text(surah\_name\_arabic)
      Text(surah\_ayah\_count)
      DownloadIcon
```

**ARB Keys:** `quran_title`, `quran_subtitle`, `continue_reading`, `listen`, `surah_ayah_count`

**مصدر النص القرآني:**

* Pack: `quran-uthmani` (Tanzil — CC BY 3.0)
* **لا نص حرفي في الكود أو الوصفات**
* يُحمَّل من `assets/quran/` عند الحاجة

**الحالات:**

* **Loading:** Skeleton list
* **Empty:** (لا يوجد — الفهرس محلي)
* **Error:** "فشل تحميل الفهرس" + إعادة المحاولة
* **Success:** عرض طبيعي
* **Downloading:** progress indicator لكل سورة

**الأحداث:**

* `onSurahTap(surah)` → `MushafViewerScreen` أو `SurahReaderScreen`
* `onDownloadTap(surah)` → تنزيل التلاوة

**الوصولية:**

* Semantic لكل سورة: "سورة البقرة، 286 آية"
* أرقام بصيغة الواجهة (Latin — DEC-0026)

**Offline:** ✅ (النص asset، التلاوة تحتاج شبكة)

**مرجع:** REQ-QURAN-001, OD-0003

---

### 🎴 وصفة 7: AzkarScreen

**الهدف:** أذكار الصباح/المساء/المطلقة مع عدّاد.

**الخلفية:** gradient + CustomPainter زخارف.

**الحالة:**

* `azkarLibraryProvider` (AsyncNotifier, keepAlive)
* `azkarSessionProvider` (Notifier, autoDispose)
* `azkarTabProvider` (Notifier, autoDispose)

**مصدر الأذكار:**

* Pack: `azkar-hisn` (حصن المسلم — حالة: NEEDS_REVIEW)
* **⚠️ المراجعة الشرعية إلزامية قبل الاعتماد**
* **لا نصوص حرفية في الوصفة**

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(
    title: AppStrings.of(context, 'azkar\_title'),
    actions: \[FavoriteButton],
  )
  body: Column
    AppTabBar(tabs: \['azkar\_morning', 'azkar\_evening', 'azkar\_general'])
    AzkarProgressHeader(progress: 3/12)
    Expanded → ListView
      ZikrCard × N
        Text(zikr\_text) // من asset، لا hardcoded
        Text(zikr\_reference)
        CircularProgress(count: 3, total: 7)
        PrimaryButton('azkar\_done')
```

**ARB Keys:** `azkar_title`, `azkar_morning`, `azkar_evening`, `azkar_general`, `azkar_done`

**الحالات:**

* **Loading:** Skeleton
* **Empty:** "لا توجد أذكار" (إن الحزمة غير محمّلة)
* **Error:** خطأ + إعادة محاولة
* **Success:** عرض طبيعي
* **Completed:** Haptic + انتقال

**الأحداث:**

* `onZikrTap(zikr)` → إنقاص العداد
* `onComplete` → HapticFeedback + Next

**الوصولية:**

* Semantic: "ذكر 1 من 12: سبحان الله وبحمده. مكتمل 3 من 7"
* Haptic معطّل عند reduced motion

**Offline:** ✅ (المحتوى asset)

**مرجع:** REQ-AZKAR-001

---

### 🎴 وصفة 8: HijriCalendarScreen

**الهدف:** تقويم هجري.

**الخلفية:** gradient.

**الحالة:**

* `hijriDateProvider` (Notifier, autoDispose)
* `hijriMonthProvider` (Notifier, autoDispose)

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(title: AppStrings.of(context, 'hijri\_calendar\_title'))
  body: Column
    MonthNavigator
      IconButton(chevron\_left)
      Text(current\_month\_hijri)
      IconButton(chevron\_right)
    CalendarGrid (7×6)
      DayCell × 42
```

**ARB Keys:** `hijri_calendar_title`, `hijri_month_format`, `hijri_today`

**الحالات:**

* **Loading:** Skeleton grid
* **Error:** "فشل الحساب" + إعادة محاولة
* **Success:** عرض طبيعي

**الأحداث:**

* `onDayTap(day)` → تفاصيل اليوم

**الوصولية:**

* Semantic لكل خلية: "5 ربيع الأول، يوم عادي"

**Offline:** ✅ (حساب محلي وفق OD-0005)

**مرجع:** REQ-HIJRI-001

---

### Islamic Events (deferred to v1.5)

- OD-0031
- لا مناسبات في v1.0

---

### 🎴 وصفة 9: FavoritesScreen

**الهدف:** كل المحفوظات في مكان واحد.

**الخلفية:** عادي.

**الحالة:**

* `favoritesProvider` (AsyncNotifier, keepAlive)
* `favoritesFilterProvider` (Notifier, autoDispose)
* `favoritesSearchProvider` (Notifier, autoDispose)

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(title: AppStrings.of(context, 'favorites\_title'))
  body: Column
    AppTabBar(tabs: \['favorites\_all', 'favorites\_azkar', 'favorites\_quran', 'favorites\_duas'])
    SearchBar
    Expanded → ListView
      FavoriteItem × N
        Icon(type)
        Text(content\_preview)
        Text(source)
        Dismissible (swipe to delete)
```

**ARB Keys:** `favorites_title`, `favorites_all`, `favorites_azkar`, `favorites_quran`, `favorites_duas`, `favorites_empty`

**الحالات:**

* **Loading:** Skeleton list
* **Empty:** "لم تحفظ شيئًا بعد" + CTA
* **Error:** خطأ + retry
* **Success:** عرض طبيعي

**الأحداث:**

* `onItemTap(item)` → فتح العنصر
* `onSwipeDelete(item)` → حذف + SnackBar "undo_favorite_delete"

**الوصولية:**

* Semantic لكل عنصر
* Swipe مؤكد بـ SnackBar (إمكانية التراجع)

**Offline:** ✅ (المحتوى محلي)

**مرجع:** REQ-FAV-001

---

### 🎴 وصفة 10: SearchScreen

**الهدف:** بحث موحد في كل المحتوى.

**الخلفية:** عادي.

**الحالة:**

* `searchQueryProvider` (Notifier, autoDispose)
* `searchResultsProvider` (AsyncNotifier, autoDispose)
* `searchCategoryProvider` (Notifier, autoDispose)

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(title: AppStrings.of(context, 'search\_title'))
  body: Column
    SearchBar (TextField + Icon)
    CategoryChips (all, quran, azkar, duas, allah\_names)
    Expanded → ListView
      SearchResultItem × N
        Icon(type)
        Text(highlighted\_match)
        Text(source)
        GoButton
```

**ARB Keys:** `search_title`, `search_placeholder`, `search_category_all`, `search_no_results`, `search_results_count`

**الحالات:**

* **Loading:** LinearProgress
* **Empty:** "لا نتائج لـ «[query]»" + suggestions
* **Error:** خطأ + retry
* **Success:** عرض طبيعي
* **Typing:** Debounce 300ms

**الأحداث:**

* `onQueryChange` → بحث فوري (debounce 300ms)
* `onResultTap` → فتح العنصر

**الوصولية:**

* Semantic: "نتيجة 1: البقرة — سورة"
* إعلان عدد النتائج عبر `SemanticsService.announce`

**Offline:** ✅ (البحث محلي — OD-0002, OD-0004)

**مرجع:** REQ-SEARCH-001

---

### 🎴 وصفة 11: SettingsScreen

**الهدف:** كل التفضيلات.

**الخلفية:** عادي.

**الحالة:**

* `settingsProvider` (Notifier, keepAlive)

**شجرة الويدجتات:**

```text
Scaffold
  AppTopBar(title: AppStrings.of(context, 'settings\_title'))
  body: ListView
    SectionHeader('settings\_language\_display')
    SwitchTile('settings\_arabic\_numerals')
    SwitchTile('settings\_24h\_time')
    SwitchTile('settings\_dark\_mode')
    SectionHeader('settings\_prayer')
    ListTile('settings\_calculation\_method') → Dropdown
    ListTile('settings\_asr\_method') → Dropdown
    SwitchTile('settings\_adhan\_notifications')
    ListTile('settings\_adhan\_sound') → Dropdown
    SectionHeader('settings\_azkar')
    SwitchTile('settings\_azkar\_notifications')
    ListTile('settings\_azkar\_time')
    SectionHeader('settings\_home')
    SwitchTile('settings\_home\_reorder\_enabled')
    ListTile('settings\_home\_visible\_cards')
    SectionHeader('settings\_data')
    ListTile('settings\_export\_data')
    ListTile('settings\_clear\_data')
    ListTile('settings\_view\_error\_log')
    SectionHeader('settings\_about')
    ListTile('settings\_sources')
    ListTile('settings\_privacy\_policy')
    ListTile('settings\_about\_app')
```

**ARB Keys:** (جميع المفاتيح في القائمة)

**الحالات:**

* **Loading:** Skeleton
* **Success:** عرض طبيعي

**الأحداث:**

* كل تغيير → `settingsRepository` (حفظ تلقائي)

**الوصولية:**

* Semantic لكل Switch/ListTile
* Focus order top-to-bottom

**Offline:** ✅

**مرجع:** REQ-SETTINGS-001

---

### 🎴 وصفة 12: JumuahCard (Dialog)

**الهدف:** تظهر يوم الجمعة مرة واحدة.

**الخلفية:** `IslamicSceneBanner` (رسم برمجي).

**الحالة:**

* `jumuahCardShownProvider` (Notifier, keepAlive)

**شجرة الويدجتات:**

```text
Dialog
  Stack
    IslamicSceneBanner
    Column
      IconButton(close)
      Text(AppStrings.of(context, 'jumuah\_greeting'), style: displayMedium)
      Text('\[PLACEHOLDER-AYAH-JUMUAH-001]', style: bodyLarge)
      Text('\[PLACEHOLDER-AYAH-JUMUAH-001-REF]', style: bodySmall)
      PrimaryButton('jumuah\_read\_dua')
```

**ARB Keys:** `jumuah_greeting`, `jumuah_read_dua`, `jumuah_dont_show_again`

**المحتوى الديني:**

* ⛔ **لا آية حرفية** — `[PLACEHOLDER-AYAH-JUMUAH-001]`
* المصدر: pack معتمد (quran-uthmani)
* المراجع: `content/reviewers.yaml` (shaykh-4)
* الحالة: pending

**الحالات:**

* **Loading:** (لا يوجد)
* **Success:** عرض طبيعي

**الأحداث:**

* `onReadDua` → فتح الأدعية
* `onClose` → إغلاق
* `onDontShowAgain` → `settingsRepository.setJumuahCardEnabled(false)`

**قواعد:**

* تظهر **مرة واحدة** يوم الجمعة
* الإعدادات: `settings_jumuah_card_enabled` = ON/OFF
* لا Timer خلفي — تُفحص عند فتح التطبيق

**الوصولية:**

* Semantic: "بطاقة الجمعة — اضغط لقراءة الدعاء"

**Offline:** ✅

---

## 4. الأصول (Assets Inventory)

**كل أصل يجب تسجيله في `legal/assets.yaml`.**

|Asset ID|النوع|المسار|المصدر|الترخيص|الحالة|
|-|-|-|-|-|-|
|`splash-bg`|image|`assets/images/splash_bg.webp`|**TBD**|**TBD**|PROPOSED|
|`app-logo-mark`|image|`assets/images/app_logo_mark.png`|فريق التطوير|MIT (تطبيق)|PROPOSED|
|`prayer-hero-haram`|image|`assets/images/prayer_hero_haram.webp`|**TBD**|**TBD**|PROPOSED|
|`qibla-bg`|image|`assets/images/qibla_bg.webp`|**TBD**|**TBD**|PROPOSED|
|`kaaba-badge`|image|`assets/images/kaaba_badge.webp`|**TBD**|**TBD**|PROPOSED|
|`quran-book`|image|`assets/images/quran_book.webp`|**TBD**|**TBD**|PROPOSED|
|`islamic-scene-banner`|code|CustomPainter|فريق التطوير|MIT (تطبيق)|APPROVED|
|`quran-uthmani`|text|`assets/quran/`|Tanzil|CC BY 3.0|SOURCE_IDENTIFIED|
|`azkar-hisn`|text|`assets/azkar/`|حصن المسلم|**NEEDS_REVIEW**|NEEDS_REVIEW|
|`amiri-quran-font`|font|`assets/fonts/`|Amiri|OFL|LICENSE_REVIEW|

**القواعد:**

* ⛔ لا صورة `TBD` تُشحن. يجب حسم مصدرها وترخيصها أولاً.
* ✅ الرسومات البرمجية (`CustomPainter`) لا تحتاج ترخيصاً خارجياً.
* 📋 كل صورة تُسجَّل مع: source_url, license_type, checksum.

---

## 5. Riverpod Providers

|Provider|النوع|Lifecycle|التبرير|
|-|-|-|-|
|`bootstrapProvider`|AsyncNotifier|autoDispose|يُنفّذ مرة عند الإقلاع|
|`settingsProvider`|Notifier|keepAlive|يُقرأ من كل مكان|
|`nextPrayerProvider`|Stream|autoDispose|يُلغى عند الخروج من Home|
|`lastReadProvider`|Notifier|keepAlive|يُستخدم في Home + Quran|
|`todayAzkarProvider`|AsyncNotifier|autoDispose|يُحدَّث عند الدخول|
|`hijriDateProvider`|Notifier|autoDispose|يُحدَّث عند منتصف الليل|
|`weeklyStatsProvider`|AsyncNotifier|keepAlive|يُستخدم في Stats|
|`favoritesProvider`|AsyncNotifier|keepAlive|يُستخدم في Home + Favorites|
|`homeCardOrderProvider`|Notifier|keepAlive|ترتيب المستخدم|
|`quranIndexProvider`|AsyncNotifier|keepAlive|فهرس ثقيل|
|`azkarLibraryProvider`|AsyncNotifier|keepAlive|مكتبة ثابتة|
|`searchResultsProvider`|AsyncNotifier|autoDispose|search مؤقت|

**القواعد:**

* `autoDispose` افتراضي — `keepAlive` بقرار موثق
* لا provider يعتمد دائرياً على آخر
* كل provider قابل للـ override في الاختبار

---

## 6. مصفوفة الحالات

|الشاشة|Loading|Empty|Error|Success|Refreshing|
|-|-|-|-|-|-|
|Splash|✅|—|✅|✅|—|
|Language Selection|—|—|—|✅|—|
|Home|✅|✅|✅|✅|✅|
|Prayer Times|✅|✅|✅|✅|✅|
|Qibla|✅|—|✅|✅|—|
|Quran|✅|—|✅|✅|✅|
|Azkar|✅|✅|✅|✅|—|
|Hijri|✅|✅|✅|✅|—|
|Favorites|✅|✅|✅|✅|—|
|Search|✅|✅|✅|✅|—|
|Settings|✅|—|—|✅|—|
|Jumuah Card|—|—|—|✅|—|

---

## 7. مصفوفة الوصولية

|الشاشة|Touch 48dp|Semantic|Text 200%|TalkBack|Reduced Motion|
|-|-|-|-|-|-|
|Splash|—|✅|✅|✅|✅|
|Language Selection|✅|✅|✅|✅|—|
|Home|✅|✅|✅|✅|✅|
|Prayer Times|✅|✅|✅|✅|—|
|Qibla|✅|✅|✅|✅|✅|
|Quran|✅|✅|✅|✅|—|
|Azkar|✅|✅|✅|✅|✅|
|Hijri|✅|✅|✅|✅|—|
|Favorites|✅|✅|✅|✅|—|
|Search|✅|✅|✅|✅|—|
|Settings|✅|✅|✅|✅|—|
|Jumuah Card|✅|✅|✅|✅|—|

---

## 8. مصفوفة Offline

|الشاشة|Offline|يحتاج شبكة|
|-|-|-|
|Splash|✅|❌|
|Language Selection|✅|❌|
|Home|✅|❌|
|Prayer Times|✅|❌|
|Qibla|✅|❌|
|Quran (نص)|✅|❌|
|Quran (تلاوة)|❌|✅ (Phase 07)|
|Azkar|✅|❌|
|Hijri|✅|❌|
|Favorites|✅|❌|
|Search|✅|❌|
|Settings|✅|❌|
|Jumuah Card|✅|❌|

---

## 9. خارطة التنفيذ المرحلية

|#|الشاشة|المرحلة|الحالة|
|-|-|-|-|
|1|Splash|Phase 01|⏳|
|2|Language Selection|Phase 01|⏳|
|3|Welcome Shell|Phase 01|⏳|
|4|Settings (shell)|Phase 01|⏳|
|5|Prayer Times|Phase 02|—|
|6|Qibla|Phase 03|—|
|7|Azkar|Phase 05|—|
|8|Quran (نص)|Phase 06|—|
|9|Quran (تلاوة)|Phase 07|—|
|10|Hijri|Phase 08|—|
|11|Home (Dashboard)|Phase 10|—|
|12|Favorites|Phase 11|—|
|13|Search|Phase 12|—|
|14|Jumuah Card|Phase 10+|—|

**⚠️ لا تُنفَّذ شاشة قبل مرحلتها.** هذا التصميم رؤية، وليس تسلسلاً تنفيذياً.

---

## 10. المراجع

* `README.md`
* `00-integrity-rules.md`
* `architecture/07-localization.md`
* `content/00-content-policy.md`
* `legal/00-licensing-policy.md`
* `product/05-accessibility.md`
* `product/06-onboarding.md`
* `phases/01.md`
* `03-decisions.md` (DEC-0024 → DEC-0027)
* `04-open-decisions.md` (OD-0008, OD-0010, OD-0012, OD-0013)

---

**نهاية الوثيقة — UI Vision v1.0**
