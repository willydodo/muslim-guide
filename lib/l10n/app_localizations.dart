import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @app_name.
  ///
  /// In ar, this message translates to:
  /// **'دليل المسلم'**
  String get app_name;

  /// No description provided for @app_tagline.
  ///
  /// In ar, this message translates to:
  /// **'رفيقك في العبادة'**
  String get app_tagline;

  /// No description provided for @onboarding_choose_language.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get onboarding_choose_language;

  /// No description provided for @onboarding_continue.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get onboarding_continue;

  /// No description provided for @language_arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get language_arabic;

  /// No description provided for @language_english.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @splash_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التهيئة'**
  String get splash_loading;

  /// No description provided for @splash_error.
  ///
  /// In ar, this message translates to:
  /// **'فشل التهيئة'**
  String get splash_error;

  /// No description provided for @splash_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get splash_retry;

  /// No description provided for @home_greeting.
  ///
  /// In ar, this message translates to:
  /// **'السلام عليكم'**
  String get home_greeting;

  /// No description provided for @onboarding_save_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ الإعدادات. حاول مرة أخرى.'**
  String get onboarding_save_error;

  /// No description provided for @language_arabic_semantics.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة العربية'**
  String get language_arabic_semantics;

  /// No description provided for @language_english_semantics.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة الإنجليزية'**
  String get language_english_semantics;

  /// No description provided for @prayer_title.
  ///
  /// In ar, this message translates to:
  /// **'مواقيت الصلاة'**
  String get prayer_title;

  /// No description provided for @prayer_fajr.
  ///
  /// In ar, this message translates to:
  /// **'الفجر'**
  String get prayer_fajr;

  /// No description provided for @prayer_sunrise.
  ///
  /// In ar, this message translates to:
  /// **'الشروق'**
  String get prayer_sunrise;

  /// No description provided for @sunrise_not_obligatory.
  ///
  /// In ar, this message translates to:
  /// **'ليست صلاة فريضة'**
  String get sunrise_not_obligatory;

  /// No description provided for @prayer_dhuhr.
  ///
  /// In ar, this message translates to:
  /// **'الظهر'**
  String get prayer_dhuhr;

  /// No description provided for @prayer_asr.
  ///
  /// In ar, this message translates to:
  /// **'العصر'**
  String get prayer_asr;

  /// No description provided for @prayer_maghrib.
  ///
  /// In ar, this message translates to:
  /// **'المغرب'**
  String get prayer_maghrib;

  /// No description provided for @prayer_isha.
  ///
  /// In ar, this message translates to:
  /// **'العشاء'**
  String get prayer_isha;

  /// No description provided for @prayer_no_location.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تحديد الموقع'**
  String get prayer_no_location;

  /// No description provided for @prayer_set_location.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الموقع'**
  String get prayer_set_location;

  /// No description provided for @prayer_calc_error.
  ///
  /// In ar, this message translates to:
  /// **'فشل حساب المواقيت'**
  String get prayer_calc_error;

  /// No description provided for @prayer_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get prayer_retry;

  /// No description provided for @prayer_no_next_today.
  ///
  /// In ar, this message translates to:
  /// **'لا صلاة قادمة اليوم'**
  String get prayer_no_next_today;

  /// No description provided for @prayer_time_unavailable.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح'**
  String get prayer_time_unavailable;

  /// No description provided for @prayer_current_location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع الحالي'**
  String get prayer_current_location;

  /// No description provided for @prayer_notification_settings.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات التنبيه'**
  String get prayer_notification_settings;

  /// No description provided for @location_picker_title.
  ///
  /// In ar, this message translates to:
  /// **'اختيار الموقع'**
  String get location_picker_title;

  /// No description provided for @location_picker_search_hint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مدينة'**
  String get location_picker_search_hint;

  /// No description provided for @location_picker_use_gps.
  ///
  /// In ar, this message translates to:
  /// **'استخدام موقعي'**
  String get location_picker_use_gps;

  /// No description provided for @location_picker_permission_denied.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض صلاحية الموقع'**
  String get location_picker_permission_denied;

  /// No description provided for @location_picker_empty.
  ///
  /// In ar, this message translates to:
  /// **'لا نتائج'**
  String get location_picker_empty;

  /// No description provided for @location_picker_gps_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحديد موقعك'**
  String get location_picker_gps_error;

  /// No description provided for @prayer_settings_coming_soon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get prayer_settings_coming_soon;

  /// No description provided for @prayer_change_city.
  ///
  /// In ar, this message translates to:
  /// **'تغيير المدينة'**
  String get prayer_change_city;

  /// No description provided for @qibla_title.
  ///
  /// In ar, this message translates to:
  /// **'القبلة'**
  String get qibla_title;

  /// No description provided for @qibla_direction_label.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه القبلة'**
  String get qibla_direction_label;

  /// No description provided for @qibla_calibrate.
  ///
  /// In ar, this message translates to:
  /// **'حرّك الجهاز بشكل رقم 8 للمعايرة'**
  String get qibla_calibrate;

  /// No description provided for @qibla_no_sensor.
  ///
  /// In ar, this message translates to:
  /// **'الجهاز لا يدعم البوصلة'**
  String get qibla_no_sensor;

  /// No description provided for @qibla_no_location.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تحديد الموقع'**
  String get qibla_no_location;

  /// No description provided for @qibla_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر قراءة البوصلة'**
  String get qibla_error;

  /// No description provided for @qibla_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get qibla_retry;

  /// No description provided for @qibla_open_settings.
  ///
  /// In ar, this message translates to:
  /// **'تغيير المدينة'**
  String get qibla_open_settings;

  /// No description provided for @notif_diag_title.
  ///
  /// In ar, this message translates to:
  /// **'تشخيص الإشعارات'**
  String get notif_diag_title;

  /// No description provided for @notif_diag_explainer.
  ///
  /// In ar, this message translates to:
  /// **'تحقق من أذونات النظام اللازمة لإشعارات الصلاة والتنبيهات الدقيقة.'**
  String get notif_diag_explainer;

  /// No description provided for @notif_diag_notifications_title.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notif_diag_notifications_title;

  /// No description provided for @notif_diag_notifications_granted.
  ///
  /// In ar, this message translates to:
  /// **'إذن الإشعارات ممنوح.'**
  String get notif_diag_notifications_granted;

  /// No description provided for @notif_diag_notifications_denied.
  ///
  /// In ar, this message translates to:
  /// **'إذن الإشعارات غير ممنوح.'**
  String get notif_diag_notifications_denied;

  /// No description provided for @notif_diag_exact_alarms_title.
  ///
  /// In ar, this message translates to:
  /// **'التنبيهات الدقيقة'**
  String get notif_diag_exact_alarms_title;

  /// No description provided for @notif_diag_exact_alarms_granted.
  ///
  /// In ar, this message translates to:
  /// **'إذن التنبيهات الدقيقة ممنوح.'**
  String get notif_diag_exact_alarms_granted;

  /// No description provided for @notif_diag_exact_alarms_denied.
  ///
  /// In ar, this message translates to:
  /// **'إذن التنبيهات الدقيقة غير ممنوح.'**
  String get notif_diag_exact_alarms_denied;

  /// No description provided for @notif_diag_not_applicable.
  ///
  /// In ar, this message translates to:
  /// **'غير مطلوب على إصدار أندرويد هذا.'**
  String get notif_diag_not_applicable;

  /// No description provided for @notif_diag_request.
  ///
  /// In ar, this message translates to:
  /// **'طلب الإذن'**
  String get notif_diag_request;

  /// No description provided for @notif_diag_open_settings.
  ///
  /// In ar, this message translates to:
  /// **'فتح إعدادات الإشعارات'**
  String get notif_diag_open_settings;

  /// No description provided for @notif_diag_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get notif_diag_retry;

  /// No description provided for @notif_diag_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر قراءة حالة الأذونات. حاول مرة أخرى.'**
  String get notif_diag_error;

  /// No description provided for @notif_prayer_title_fajr.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الفجر'**
  String get notif_prayer_title_fajr;

  /// No description provided for @notif_prayer_title_dhuhr.
  ///
  /// In ar, this message translates to:
  /// **'صلاة الظهر'**
  String get notif_prayer_title_dhuhr;

  /// No description provided for @notif_prayer_title_asr.
  ///
  /// In ar, this message translates to:
  /// **'صلاة العصر'**
  String get notif_prayer_title_asr;

  /// No description provided for @notif_prayer_title_maghrib.
  ///
  /// In ar, this message translates to:
  /// **'صلاة المغرب'**
  String get notif_prayer_title_maghrib;

  /// No description provided for @notif_prayer_title_isha.
  ///
  /// In ar, this message translates to:
  /// **'صلاة العشاء'**
  String get notif_prayer_title_isha;

  /// No description provided for @notif_prayer_body.
  ///
  /// In ar, this message translates to:
  /// **'حان وقت الصلاة'**
  String get notif_prayer_body;

  /// No description provided for @notif_channel_prayer_adhan_name.
  ///
  /// In ar, this message translates to:
  /// **'إشعارات الصلاة'**
  String get notif_channel_prayer_adhan_name;

  /// No description provided for @notif_channel_prayer_adhan_description.
  ///
  /// In ar, this message translates to:
  /// **'تنبيهات صوتية لمواقيت الصلاة'**
  String get notif_channel_prayer_adhan_description;

  /// No description provided for @adhan_player_play.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل الأذان'**
  String get adhan_player_play;

  /// No description provided for @adhan_player_stop.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف الأذان'**
  String get adhan_player_stop;

  /// No description provided for @adhan_player_restart.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تشغيل الأذان'**
  String get adhan_player_restart;

  /// No description provided for @adhan_player_state_idle.
  ///
  /// In ar, this message translates to:
  /// **'جاهز'**
  String get adhan_player_state_idle;

  /// No description provided for @adhan_player_state_loading.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ تحميل الصوت'**
  String get adhan_player_state_loading;

  /// No description provided for @adhan_player_state_playing.
  ///
  /// In ar, this message translates to:
  /// **'يعمل الآن'**
  String get adhan_player_state_playing;

  /// No description provided for @adhan_player_state_paused.
  ///
  /// In ar, this message translates to:
  /// **'متوقف مؤقتاً'**
  String get adhan_player_state_paused;

  /// No description provided for @adhan_player_state_completed.
  ///
  /// In ar, this message translates to:
  /// **'انتهى التشغيل'**
  String get adhan_player_state_completed;

  /// No description provided for @adhan_player_state_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تشغيل الصوت'**
  String get adhan_player_state_error;

  /// No description provided for @adhan_player_state_interrupted.
  ///
  /// In ar, this message translates to:
  /// **'توقف بسبب مقاطعة'**
  String get adhan_player_state_interrupted;

  /// No description provided for @night_first_third.
  ///
  /// In ar, this message translates to:
  /// **'الثلث الأول'**
  String get night_first_third;

  /// No description provided for @night_last_third_tahajjud.
  ///
  /// In ar, this message translates to:
  /// **'الثلث الأخير (التهجد)'**
  String get night_last_third_tahajjud;

  /// No description provided for @prayer_notification_enabled.
  ///
  /// In ar, this message translates to:
  /// **'إشعار الصلاة مفعّل'**
  String get prayer_notification_enabled;

  /// No description provided for @prayer_notification_disabled.
  ///
  /// In ar, this message translates to:
  /// **'إشعار الصلاة معطّل'**
  String get prayer_notification_disabled;

  /// No description provided for @settings_notifications_title.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الإشعارات'**
  String get settings_notifications_title;

  /// No description provided for @settings_section_prayer_alerts.
  ///
  /// In ar, this message translates to:
  /// **'تنبيهات الصلوات'**
  String get settings_section_prayer_alerts;

  /// No description provided for @settings_prayer_alerts_hint.
  ///
  /// In ar, this message translates to:
  /// **'فعّل/عطّل إشعارات كل صلاة'**
  String get settings_prayer_alerts_hint;

  /// No description provided for @settings_prayer_alerts_all_off.
  ///
  /// In ar, this message translates to:
  /// **'جميع تنبيهات الصلاة معطّلة'**
  String get settings_prayer_alerts_all_off;

  /// No description provided for @settings_section_notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get settings_section_notifications;

  /// No description provided for @settings_notifications_on.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات مفعّلة.'**
  String get settings_notifications_on;

  /// No description provided for @settings_notifications_off.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات غير مفعّلة بالكامل.'**
  String get settings_notifications_off;

  /// No description provided for @settings_open_diagnostics.
  ///
  /// In ar, this message translates to:
  /// **'فتح تشخيص الإشعارات'**
  String get settings_open_diagnostics;

  /// No description provided for @settings_section_adhan.
  ///
  /// In ar, this message translates to:
  /// **'الأذان'**
  String get settings_section_adhan;

  /// No description provided for @settings_adhan_sound.
  ///
  /// In ar, this message translates to:
  /// **'صوت الأذان'**
  String get settings_adhan_sound;

  /// No description provided for @settings_adhan_sound_coming_soon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get settings_adhan_sound_coming_soon;

  /// No description provided for @settings_section_device.
  ///
  /// In ar, this message translates to:
  /// **'الجهاز'**
  String get settings_section_device;

  /// No description provided for @settings_coloros_guide.
  ///
  /// In ar, this message translates to:
  /// **'على أجهزة Oppo/ColorOS: عطّل تحسين البطارية لهذا التطبيق، واسمح بالتشغيل التلقائي والتشغيل في الخلفية لتصل إشعارات الصلاة في وقتها.'**
  String get settings_coloros_guide;

  /// No description provided for @settings_oem_note.
  ///
  /// In ar, this message translates to:
  /// **'الأجهزة الأخرى (MIUI وOneUI وEMUI) غير مختبرة بعد.'**
  String get settings_oem_note;

  /// No description provided for @settings_section_licenses.
  ///
  /// In ar, this message translates to:
  /// **'التراخيص'**
  String get settings_section_licenses;

  /// No description provided for @settings_calculation_title.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات طريقة الحساب'**
  String get settings_calculation_title;

  /// No description provided for @settings_section_calculation.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الحساب'**
  String get settings_section_calculation;

  /// No description provided for @settings_calculation_method.
  ///
  /// In ar, this message translates to:
  /// **'الطريقة'**
  String get settings_calculation_method;

  /// No description provided for @settings_asr_method.
  ///
  /// In ar, this message translates to:
  /// **'مذهب العصر'**
  String get settings_asr_method;

  /// No description provided for @settings_high_latitude_rule.
  ///
  /// In ar, this message translates to:
  /// **'قاعدة خطوط العرض العالية'**
  String get settings_high_latitude_rule;

  /// No description provided for @settings_calculation_apply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق'**
  String get settings_calculation_apply;

  /// No description provided for @settings_calculation_undo.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get settings_calculation_undo;

  /// No description provided for @calc_method_mwl.
  ///
  /// In ar, this message translates to:
  /// **'رابطة العالم الإسلامي'**
  String get calc_method_mwl;

  /// No description provided for @calc_method_egyptian.
  ///
  /// In ar, this message translates to:
  /// **'الهيئة المصرية العامة للمساحة'**
  String get calc_method_egyptian;

  /// No description provided for @calc_method_umm_al_qura.
  ///
  /// In ar, this message translates to:
  /// **'أم القرى'**
  String get calc_method_umm_al_qura;

  /// No description provided for @calc_method_karachi.
  ///
  /// In ar, this message translates to:
  /// **'جامعة العلوم الإسلامية - كراتشي'**
  String get calc_method_karachi;

  /// No description provided for @calc_method_isna.
  ///
  /// In ar, this message translates to:
  /// **'الجمعية الإسلامية لأمريكا الشمالية'**
  String get calc_method_isna;

  /// No description provided for @calc_method_tehran.
  ///
  /// In ar, this message translates to:
  /// **'معهد الجيوفيزياء - طهران'**
  String get calc_method_tehran;

  /// No description provided for @calc_method_jafari.
  ///
  /// In ar, this message translates to:
  /// **'المذهب الجعفري'**
  String get calc_method_jafari;

  /// No description provided for @asr_method_standard.
  ///
  /// In ar, this message translates to:
  /// **'الجمهور (شافعي/مالكي/حنبلي)'**
  String get asr_method_standard;

  /// No description provided for @asr_method_hanafi.
  ///
  /// In ar, this message translates to:
  /// **'الحنفي'**
  String get asr_method_hanafi;

  /// No description provided for @hlr_middle_of_night.
  ///
  /// In ar, this message translates to:
  /// **'منتصف الليل'**
  String get hlr_middle_of_night;

  /// No description provided for @hlr_seventh_of_night.
  ///
  /// In ar, this message translates to:
  /// **'سُبع الليل'**
  String get hlr_seventh_of_night;

  /// No description provided for @hlr_twilight_angle.
  ///
  /// In ar, this message translates to:
  /// **'زاوية الشفق'**
  String get hlr_twilight_angle;

  /// No description provided for @hlr_none.
  ///
  /// In ar, this message translates to:
  /// **'لا شيء'**
  String get hlr_none;

  /// SnackBar after auto-applying the country default method
  ///
  /// In ar, this message translates to:
  /// **'تم تطبيق: {method}'**
  String settings_calculation_applied(String method);

  /// Quiet suggestion inside the calculation settings screen
  ///
  /// In ar, this message translates to:
  /// **'الاقتراح لبلدك: {method}'**
  String settings_calculation_suggestion(String method);

  /// No description provided for @settings_licenses.
  ///
  /// In ar, this message translates to:
  /// **'تراخيص المصادر المفتوحة'**
  String get settings_licenses;

  /// No description provided for @settings_section_about.
  ///
  /// In ar, this message translates to:
  /// **'حول'**
  String get settings_section_about;

  /// No description provided for @settings_app_version.
  ///
  /// In ar, this message translates to:
  /// **'0.1.0+1'**
  String get settings_app_version;

  /// No description provided for @azkar_library_title.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get azkar_library_title;

  /// No description provided for @azkar_library_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل الأذكار'**
  String get azkar_library_loading;

  /// No description provided for @azkar_library_empty.
  ///
  /// In ar, this message translates to:
  /// **'لا فئات متاحة'**
  String get azkar_library_empty;

  /// No description provided for @azkar_library_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الأذكار'**
  String get azkar_library_error;

  /// No description provided for @azkar_detail_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل الذكر'**
  String get azkar_detail_loading;

  /// No description provided for @azkar_detail_empty.
  ///
  /// In ar, this message translates to:
  /// **'لا عناصر في هذه الفئة'**
  String get azkar_detail_empty;

  /// No description provided for @azkar_detail_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل التفاصيل'**
  String get azkar_detail_error;

  /// No description provided for @azkar_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get azkar_retry;

  /// No description provided for @azkar_category_morning.
  ///
  /// In ar, this message translates to:
  /// **'أذكار الصباح'**
  String get azkar_category_morning;

  /// No description provided for @azkar_category_evening.
  ///
  /// In ar, this message translates to:
  /// **'أذكار المساء'**
  String get azkar_category_evening;

  /// No description provided for @azkar_category_sleep.
  ///
  /// In ar, this message translates to:
  /// **'أذكار النوم'**
  String get azkar_category_sleep;

  /// No description provided for @azkar_category_wake_up.
  ///
  /// In ar, this message translates to:
  /// **'أذكار الاستيقاظ'**
  String get azkar_category_wake_up;

  /// No description provided for @azkar_category_tasbih.
  ///
  /// In ar, this message translates to:
  /// **'تسابيح'**
  String get azkar_category_tasbih;

  /// No description provided for @azkar_complete_one.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get azkar_complete_one;

  /// No description provided for @azkar_counter_semantics.
  ///
  /// In ar, this message translates to:
  /// **'تقدم اليوم'**
  String get azkar_counter_semantics;

  /// No description provided for @azkar_home_title.
  ///
  /// In ar, this message translates to:
  /// **'أذكار اليوم'**
  String get azkar_home_title;

  /// No description provided for @azkar_home_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل تقدم الأذكار'**
  String get azkar_home_loading;

  /// No description provided for @azkar_home_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل تقدم الأذكار'**
  String get azkar_home_error;

  /// No description provided for @azkar_empty_pending_pack.
  ///
  /// In ar, this message translates to:
  /// **'مكتبة الأذكار قيد الإعداد'**
  String get azkar_empty_pending_pack;

  /// No description provided for @quran_title.
  ///
  /// In ar, this message translates to:
  /// **'القرآن الكريم'**
  String get quran_title;

  /// No description provided for @quran_index_title.
  ///
  /// In ar, this message translates to:
  /// **'فهرس السور'**
  String get quran_index_title;

  /// Verse count label for a surah row (Latin digits via interpolation, DEC-0026)
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, one{آية واحدة} two{آيتان} few{{count} آيات} other{{count} آية}}'**
  String quran_surah_verse_count(int count);

  /// No description provided for @quran_revelation_meccan.
  ///
  /// In ar, this message translates to:
  /// **'مكية'**
  String get quran_revelation_meccan;

  /// No description provided for @quran_revelation_medinan.
  ///
  /// In ar, this message translates to:
  /// **'مدنية'**
  String get quran_revelation_medinan;

  /// No description provided for @quran_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل'**
  String get quran_loading;

  /// No description provided for @quran_error.
  ///
  /// In ar, this message translates to:
  /// **'فشل التحميل'**
  String get quran_error;

  /// No description provided for @quran_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get quran_retry;

  /// No description provided for @quran_attribution.
  ///
  /// In ar, this message translates to:
  /// **'المصدر: Tanzil.net'**
  String get quran_attribution;

  /// No description provided for @verse_actions_copy.
  ///
  /// In ar, this message translates to:
  /// **'نسخ'**
  String get verse_actions_copy;

  /// No description provided for @verse_actions_share.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get verse_actions_share;

  /// No description provided for @verse_actions_cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get verse_actions_cancel;

  /// No description provided for @verse_actions_copied.
  ///
  /// In ar, this message translates to:
  /// **'تم النسخ'**
  String get verse_actions_copied;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
