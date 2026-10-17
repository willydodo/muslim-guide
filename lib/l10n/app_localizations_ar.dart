// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get app_name => 'دليل المسلم';

  @override
  String get app_tagline => 'رفيقك في العبادة';

  @override
  String get onboarding_choose_language => 'اختر اللغة';

  @override
  String get onboarding_continue => 'متابعة';

  @override
  String get language_arabic => 'العربية';

  @override
  String get language_english => 'English';

  @override
  String get splash_loading => 'جاري التهيئة';

  @override
  String get splash_error => 'فشل التهيئة';

  @override
  String get splash_retry => 'إعادة المحاولة';

  @override
  String get home_greeting => 'السلام عليكم';

  @override
  String get onboarding_save_error => 'تعذر حفظ الإعدادات. حاول مرة أخرى.';

  @override
  String get language_arabic_semantics => 'اختر اللغة العربية';

  @override
  String get language_english_semantics => 'اختر اللغة الإنجليزية';

  @override
  String get prayer_title => 'مواقيت الصلاة';

  @override
  String get prayer_fajr => 'الفجر';

  @override
  String get prayer_sunrise => 'الشروق';

  @override
  String get sunrise_not_obligatory => 'ليست صلاة فريضة';

  @override
  String get prayer_dhuhr => 'الظهر';

  @override
  String get prayer_asr => 'العصر';

  @override
  String get prayer_maghrib => 'المغرب';

  @override
  String get prayer_isha => 'العشاء';

  @override
  String get prayer_no_location => 'لم يتم تحديد الموقع';

  @override
  String get prayer_set_location => 'تحديد الموقع';

  @override
  String get prayer_calc_error => 'فشل حساب المواقيت';

  @override
  String get prayer_retry => 'إعادة المحاولة';

  @override
  String get prayer_no_next_today => 'لا صلاة قادمة اليوم';

  @override
  String get prayer_time_unavailable => 'غير متاح';

  @override
  String get prayer_current_location => 'الموقع الحالي';

  @override
  String get prayer_notification_settings => 'إعدادات التنبيه';

  @override
  String get location_picker_title => 'اختيار الموقع';

  @override
  String get location_picker_search_hint => 'ابحث عن مدينة';

  @override
  String get location_picker_use_gps => 'استخدام موقعي';

  @override
  String get location_picker_permission_denied => 'تم رفض صلاحية الموقع';

  @override
  String get location_picker_empty => 'لا نتائج';

  @override
  String get location_picker_gps_error => 'تعذر تحديد موقعك';

  @override
  String get prayer_settings_coming_soon => 'قريباً';

  @override
  String get prayer_change_city => 'تغيير المدينة';

  @override
  String get qibla_title => 'القبلة';

  @override
  String get qibla_direction_label => 'اتجاه القبلة';

  @override
  String get qibla_calibrate => 'حرّك الجهاز بشكل رقم 8 للمعايرة';

  @override
  String get qibla_no_sensor => 'الجهاز لا يدعم البوصلة';

  @override
  String get qibla_no_location => 'لم يتم تحديد الموقع';

  @override
  String get qibla_error => 'تعذّر قراءة البوصلة';

  @override
  String get qibla_retry => 'إعادة المحاولة';

  @override
  String get qibla_open_settings => 'تغيير المدينة';

  @override
  String get notif_diag_title => 'تشخيص الإشعارات';

  @override
  String get notif_diag_explainer =>
      'تحقق من أذونات النظام اللازمة لإشعارات الصلاة والتنبيهات الدقيقة.';

  @override
  String get notif_diag_notifications_title => 'الإشعارات';

  @override
  String get notif_diag_notifications_granted => 'إذن الإشعارات ممنوح.';

  @override
  String get notif_diag_notifications_denied => 'إذن الإشعارات غير ممنوح.';

  @override
  String get notif_diag_exact_alarms_title => 'التنبيهات الدقيقة';

  @override
  String get notif_diag_exact_alarms_granted => 'إذن التنبيهات الدقيقة ممنوح.';

  @override
  String get notif_diag_exact_alarms_denied =>
      'إذن التنبيهات الدقيقة غير ممنوح.';

  @override
  String get notif_diag_not_applicable => 'غير مطلوب على إصدار أندرويد هذا.';

  @override
  String get notif_diag_request => 'طلب الإذن';

  @override
  String get notif_diag_open_settings => 'فتح إعدادات الإشعارات';

  @override
  String get notif_diag_retry => 'إعادة المحاولة';

  @override
  String get notif_diag_error => 'تعذر قراءة حالة الأذونات. حاول مرة أخرى.';

  @override
  String get notif_prayer_title_fajr => 'صلاة الفجر';

  @override
  String get notif_prayer_title_dhuhr => 'صلاة الظهر';

  @override
  String get notif_prayer_title_asr => 'صلاة العصر';

  @override
  String get notif_prayer_title_maghrib => 'صلاة المغرب';

  @override
  String get notif_prayer_title_isha => 'صلاة العشاء';

  @override
  String get notif_prayer_body => 'حان وقت الصلاة';

  @override
  String get notif_channel_prayer_adhan_name => 'إشعارات الصلاة';

  @override
  String get notif_channel_prayer_adhan_description =>
      'تنبيهات صوتية لمواقيت الصلاة';

  @override
  String get adhan_player_play => 'تشغيل الأذان';

  @override
  String get adhan_player_stop => 'إيقاف الأذان';

  @override
  String get adhan_player_restart => 'إعادة تشغيل الأذان';

  @override
  String get adhan_player_state_idle => 'جاهز';

  @override
  String get adhan_player_state_loading => 'جارٍ تحميل الصوت';

  @override
  String get adhan_player_state_playing => 'يعمل الآن';

  @override
  String get adhan_player_state_paused => 'متوقف مؤقتاً';

  @override
  String get adhan_player_state_completed => 'انتهى التشغيل';

  @override
  String get adhan_player_state_error => 'تعذر تشغيل الصوت';

  @override
  String get adhan_player_state_interrupted => 'توقف بسبب مقاطعة';

  @override
  String get night_first_third => 'الثلث الأول';

  @override
  String get night_last_third_tahajjud => 'الثلث الأخير (التهجد)';

  @override
  String get prayer_notification_enabled => 'إشعار الصلاة مفعّل';

  @override
  String get prayer_notification_disabled => 'إشعار الصلاة معطّل';

  @override
  String get settings_notifications_title => 'إعدادات الإشعارات';

  @override
  String get settings_section_prayer_alerts => 'تنبيهات الصلوات';

  @override
  String get settings_prayer_alerts_hint => 'فعّل/عطّل إشعارات كل صلاة';

  @override
  String get settings_prayer_alerts_all_off => 'جميع تنبيهات الصلاة معطّلة';

  @override
  String get settings_section_notifications => 'الإشعارات';

  @override
  String get settings_notifications_on => 'الإشعارات مفعّلة.';

  @override
  String get settings_notifications_off => 'الإشعارات غير مفعّلة بالكامل.';

  @override
  String get settings_open_diagnostics => 'فتح تشخيص الإشعارات';

  @override
  String get settings_section_adhan => 'الأذان';

  @override
  String get settings_adhan_sound => 'صوت الأذان';

  @override
  String get settings_adhan_sound_coming_soon => 'قريباً';

  @override
  String get settings_section_device => 'الجهاز';

  @override
  String get settings_coloros_guide =>
      'على أجهزة Oppo/ColorOS: عطّل تحسين البطارية لهذا التطبيق، واسمح بالتشغيل التلقائي والتشغيل في الخلفية لتصل إشعارات الصلاة في وقتها.';

  @override
  String get settings_oem_note =>
      'الأجهزة الأخرى (MIUI وOneUI وEMUI) غير مختبرة بعد.';

  @override
  String get settings_section_licenses => 'التراخيص';

  @override
  String get settings_calculation_title => 'إعدادات طريقة الحساب';

  @override
  String get settings_section_calculation => 'طريقة الحساب';

  @override
  String get settings_calculation_method => 'الطريقة';

  @override
  String get settings_asr_method => 'مذهب العصر';

  @override
  String get settings_high_latitude_rule => 'قاعدة خطوط العرض العالية';

  @override
  String get settings_calculation_apply => 'تطبيق';

  @override
  String get settings_calculation_undo => 'تراجع';

  @override
  String get calc_method_mwl => 'رابطة العالم الإسلامي';

  @override
  String get calc_method_egyptian => 'الهيئة المصرية العامة للمساحة';

  @override
  String get calc_method_umm_al_qura => 'أم القرى';

  @override
  String get calc_method_karachi => 'جامعة العلوم الإسلامية - كراتشي';

  @override
  String get calc_method_isna => 'الجمعية الإسلامية لأمريكا الشمالية';

  @override
  String get calc_method_tehran => 'معهد الجيوفيزياء - طهران';

  @override
  String get calc_method_jafari => 'المذهب الجعفري';

  @override
  String get asr_method_standard => 'الجمهور (شافعي/مالكي/حنبلي)';

  @override
  String get asr_method_hanafi => 'الحنفي';

  @override
  String get hlr_middle_of_night => 'منتصف الليل';

  @override
  String get hlr_seventh_of_night => 'سُبع الليل';

  @override
  String get hlr_twilight_angle => 'زاوية الشفق';

  @override
  String get hlr_none => 'لا شيء';

  @override
  String settings_calculation_applied(String method) {
    return 'تم تطبيق: $method';
  }

  @override
  String settings_calculation_suggestion(String method) {
    return 'الاقتراح لبلدك: $method';
  }

  @override
  String get settings_licenses => 'تراخيص المصادر المفتوحة';

  @override
  String get settings_section_about => 'حول';

  @override
  String get settings_app_version => '0.1.0+1';

  @override
  String get azkar_library_title => 'الأذكار';

  @override
  String get azkar_library_loading => 'جاري تحميل الأذكار';

  @override
  String get azkar_library_empty => 'لا فئات متاحة';

  @override
  String get azkar_library_error => 'تعذر تحميل الأذكار';

  @override
  String get azkar_detail_loading => 'جاري تحميل الذكر';

  @override
  String get azkar_detail_empty => 'لا عناصر في هذه الفئة';

  @override
  String get azkar_detail_error => 'تعذر تحميل التفاصيل';

  @override
  String get azkar_retry => 'إعادة المحاولة';

  @override
  String get azkar_category_morning => 'أذكار الصباح';

  @override
  String get azkar_category_evening => 'أذكار المساء';

  @override
  String get azkar_category_sleep => 'أذكار النوم';

  @override
  String get azkar_category_wake_up => 'أذكار الاستيقاظ';

  @override
  String get azkar_category_tasbih => 'تسابيح';

  @override
  String get azkar_complete_one => 'تم';

  @override
  String get azkar_counter_semantics => 'تقدم اليوم';

  @override
  String get azkar_home_title => 'أذكار اليوم';

  @override
  String get azkar_home_loading => 'جاري تحميل تقدم الأذكار';

  @override
  String get azkar_home_error => 'تعذر تحميل تقدم الأذكار';

  @override
  String get azkar_empty_pending_pack => 'مكتبة الأذكار قيد الإعداد';

  @override
  String get quran_title => 'القرآن الكريم';

  @override
  String get quran_index_title => 'فهرس السور';

  @override
  String quran_surah_verse_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count آية',
      few: '$count آيات',
      two: 'آيتان',
      one: 'آية واحدة',
    );
    return '$_temp0';
  }

  @override
  String get quran_revelation_meccan => 'مكية';

  @override
  String get quran_revelation_medinan => 'مدنية';

  @override
  String get quran_loading => 'جاري التحميل';

  @override
  String get quran_error => 'فشل التحميل';

  @override
  String get quran_retry => 'إعادة المحاولة';

  @override
  String get quran_attribution => 'المصدر: Tanzil.net';

  @override
  String get verse_actions_copy => 'نسخ';

  @override
  String get verse_actions_share => 'مشاركة';

  @override
  String get verse_actions_cancel => 'إلغاء';

  @override
  String get verse_actions_copied => 'تم النسخ';

  @override
  String get hijri_calendar_title => 'التقويم الهجري';

  @override
  String hijri_month_format(String month, int year) {
    return '$month $year';
  }

  @override
  String get hijri_today => 'اليوم';

  @override
  String get hijri_loading => 'جاري التحميل';

  @override
  String get hijri_error => 'فشل الحساب';

  @override
  String get hijri_retry => 'إعادة المحاولة';

  @override
  String get hijri_adjustment_title => 'تعديل التاريخ';

  @override
  String get hijri_adjustment_minus_one => 'ناقص يوم';

  @override
  String get hijri_adjustment_none => 'بدون تعديل';

  @override
  String get hijri_adjustment_plus_one => 'زائد يوم';

  @override
  String get hijri_month_1 => 'محرم';

  @override
  String get hijri_month_2 => 'صفر';

  @override
  String get hijri_month_3 => 'ربيع الأول';

  @override
  String get hijri_month_4 => 'ربيع الآخر';

  @override
  String get hijri_month_5 => 'جمادى الأولى';

  @override
  String get hijri_month_6 => 'جمادى الآخرة';

  @override
  String get hijri_month_7 => 'رجب';

  @override
  String get hijri_month_8 => 'شعبان';

  @override
  String get hijri_month_9 => 'رمضان';

  @override
  String get hijri_month_10 => 'شوال';

  @override
  String get hijri_month_11 => 'ذو القعدة';

  @override
  String get hijri_month_12 => 'ذو الحجة';
}
