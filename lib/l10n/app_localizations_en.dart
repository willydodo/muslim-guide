// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Muslim Guide';

  @override
  String get app_tagline => 'Your worship companion';

  @override
  String get onboarding_choose_language => 'Choose Language';

  @override
  String get onboarding_continue => 'Continue';

  @override
  String get language_arabic => 'العربية';

  @override
  String get language_english => 'English';

  @override
  String get splash_loading => 'Initializing';

  @override
  String get splash_error => 'Initialization failed';

  @override
  String get splash_retry => 'Retry';

  @override
  String get home_greeting => 'Peace be upon you';

  @override
  String get onboarding_save_error =>
      'Could not save your settings. Please try again.';

  @override
  String get language_arabic_semantics => 'Select Arabic language';

  @override
  String get language_english_semantics => 'Select English language';

  @override
  String get prayer_title => 'Prayer Times';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Sunrise';

  @override
  String get sunrise_not_obligatory => 'Not an obligatory prayer';

  @override
  String get prayer_dhuhr => 'Dhuhr';

  @override
  String get prayer_asr => 'Asr';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Isha';

  @override
  String get prayer_no_location => 'No location set';

  @override
  String get prayer_set_location => 'Set location';

  @override
  String get prayer_calc_error => 'Could not calculate prayer times';

  @override
  String get prayer_retry => 'Retry';

  @override
  String get prayer_no_next_today => 'No more prayers today';

  @override
  String get prayer_time_unavailable => 'Unavailable';

  @override
  String get prayer_current_location => 'Current location';

  @override
  String get prayer_notification_settings => 'Notification settings';

  @override
  String get location_picker_title => 'Choose Location';

  @override
  String get location_picker_search_hint => 'Search for a city';

  @override
  String get location_picker_use_gps => 'Use my location';

  @override
  String get location_picker_permission_denied => 'Location permission denied';

  @override
  String get location_picker_empty => 'No results';

  @override
  String get location_picker_gps_error => 'Could not determine your location';

  @override
  String get prayer_settings_coming_soon => 'Coming soon';

  @override
  String get prayer_change_city => 'Change city';

  @override
  String get qibla_title => 'Qibla';

  @override
  String get qibla_direction_label => 'Qibla direction';

  @override
  String get qibla_calibrate => 'Move device in a figure-8 to calibrate';

  @override
  String get qibla_no_sensor => 'Compass not supported';

  @override
  String get qibla_no_location => 'Location not set';

  @override
  String get qibla_error => 'Failed to read compass';

  @override
  String get qibla_retry => 'Retry';

  @override
  String get qibla_open_settings => 'Change city';

  @override
  String get notif_diag_title => 'Notification diagnostics';

  @override
  String get notif_diag_explainer =>
      'Check system access needed for prayer notifications and exact alarms.';

  @override
  String get notif_diag_notifications_title => 'Notifications';

  @override
  String get notif_diag_notifications_granted =>
      'Notification permission is granted.';

  @override
  String get notif_diag_notifications_denied =>
      'Notification permission is not granted.';

  @override
  String get notif_diag_exact_alarms_title => 'Exact alarms';

  @override
  String get notif_diag_exact_alarms_granted =>
      'Exact-alarm access is granted.';

  @override
  String get notif_diag_exact_alarms_denied =>
      'Exact-alarm access is not granted.';

  @override
  String get notif_diag_not_applicable =>
      'Not required on this Android version.';

  @override
  String get notif_diag_request => 'Request permission';

  @override
  String get notif_diag_open_settings => 'Open notification settings';

  @override
  String get notif_diag_retry => 'Retry';

  @override
  String get notif_diag_error =>
      'Could not read permission status. Please retry.';

  @override
  String get notif_prayer_title_fajr => 'Fajr Prayer';

  @override
  String get notif_prayer_title_dhuhr => 'Dhuhr Prayer';

  @override
  String get notif_prayer_title_asr => 'Asr Prayer';

  @override
  String get notif_prayer_title_maghrib => 'Maghrib Prayer';

  @override
  String get notif_prayer_title_isha => 'Isha Prayer';

  @override
  String get notif_prayer_body => 'Prayer time';

  @override
  String get notif_channel_prayer_adhan_name => 'Prayer notifications';

  @override
  String get notif_channel_prayer_adhan_description =>
      'Audible notifications for prayer times';

  @override
  String get adhan_player_play => 'Play adhan';

  @override
  String get adhan_player_stop => 'Stop adhan';

  @override
  String get adhan_player_restart => 'Restart adhan';

  @override
  String get adhan_player_state_idle => 'Ready';

  @override
  String get adhan_player_state_loading => 'Loading audio';

  @override
  String get adhan_player_state_playing => 'Playing';

  @override
  String get adhan_player_state_paused => 'Paused';

  @override
  String get adhan_player_state_completed => 'Finished';

  @override
  String get adhan_player_state_error => 'Audio playback failed';

  @override
  String get adhan_player_state_interrupted => 'Stopped by interruption';

  @override
  String get night_first_third => 'First Third';

  @override
  String get night_last_third_tahajjud => 'Last Third (Tahajjud)';

  @override
  String get prayer_notification_enabled => 'Prayer notification on';

  @override
  String get prayer_notification_disabled => 'Prayer notification off';

  @override
  String get settings_notifications_title => 'Notification settings';

  @override
  String get settings_section_prayer_alerts => 'Prayer alerts';

  @override
  String get settings_prayer_alerts_hint => 'Enable or disable each prayer';

  @override
  String get settings_prayer_alerts_all_off => 'All prayer alerts are disabled';

  @override
  String get settings_section_notifications => 'Notifications';

  @override
  String get settings_notifications_on => 'Notifications are enabled.';

  @override
  String get settings_notifications_off =>
      'Notifications are not fully enabled.';

  @override
  String get settings_open_diagnostics => 'Open notification diagnostics';

  @override
  String get settings_section_adhan => 'Adhan';

  @override
  String get settings_adhan_sound => 'Adhan sound';

  @override
  String get settings_adhan_sound_coming_soon => 'Coming soon';

  @override
  String get settings_section_device => 'Device';

  @override
  String get settings_coloros_guide =>
      'On Oppo/ColorOS: disable battery optimization for this app, allow auto-launch, and allow background running so prayer notifications arrive on time.';

  @override
  String get settings_oem_note =>
      'Other devices (MIUI, OneUI, EMUI) are not tested yet.';

  @override
  String get settings_section_licenses => 'Licenses';

  @override
  String get settings_calculation_title => 'Calculation settings';

  @override
  String get settings_section_calculation => 'Calculation method';

  @override
  String get settings_calculation_method => 'Method';

  @override
  String get settings_asr_method => 'Asr school';

  @override
  String get settings_high_latitude_rule => 'High-latitude rule';

  @override
  String get settings_calculation_apply => 'Apply';

  @override
  String get settings_calculation_undo => 'Undo';

  @override
  String get calc_method_mwl => 'Muslim World League';

  @override
  String get calc_method_egyptian => 'Egyptian General Authority of Survey';

  @override
  String get calc_method_umm_al_qura => 'Umm al-Qura';

  @override
  String get calc_method_karachi => 'University of Islamic Sciences, Karachi';

  @override
  String get calc_method_isna => 'Islamic Society of North America';

  @override
  String get calc_method_tehran =>
      'Institute of Geophysics, University of Tehran';

  @override
  String get calc_method_jafari => 'Shia Ithna-Ashari (Jafari)';

  @override
  String get asr_method_standard => 'Standard (Shafi\'i/Maliki/Hanbali)';

  @override
  String get asr_method_hanafi => 'Hanafi';

  @override
  String get hlr_middle_of_night => 'Middle of the Night';

  @override
  String get hlr_seventh_of_night => 'Seventh of the Night';

  @override
  String get hlr_twilight_angle => 'Twilight Angle';

  @override
  String get hlr_none => 'None';

  @override
  String settings_calculation_applied(String method) {
    return 'Applied: $method';
  }

  @override
  String settings_calculation_suggestion(String method) {
    return 'Suggested for your country: $method';
  }

  @override
  String get settings_licenses => 'Open-source licenses';

  @override
  String get settings_section_about => 'About';

  @override
  String get settings_app_version => '0.1.0+1';

  @override
  String get azkar_library_title => 'Azkar';

  @override
  String get azkar_library_loading => 'Loading azkar';

  @override
  String get azkar_library_empty => 'No categories available';

  @override
  String get azkar_library_error => 'Could not load azkar';

  @override
  String get azkar_detail_loading => 'Loading details';

  @override
  String get azkar_detail_empty => 'No items in this category';

  @override
  String get azkar_detail_error => 'Could not load details';

  @override
  String get azkar_retry => 'Retry';

  @override
  String get azkar_category_morning => 'Morning azkar';

  @override
  String get azkar_category_evening => 'Evening azkar';

  @override
  String get azkar_category_sleep => 'Sleep azkar';

  @override
  String get azkar_category_wake_up => 'Wake-up azkar';

  @override
  String get azkar_category_tasbih => 'Tasbih';

  @override
  String get azkar_complete_one => 'Done';

  @override
  String get azkar_counter_semantics => 'Today\'s progress';

  @override
  String get azkar_home_title => 'Today\'s azkar';

  @override
  String get azkar_home_loading => 'Loading azkar progress';

  @override
  String get azkar_home_error => 'Could not load azkar progress';

  @override
  String get azkar_empty_pending_pack => 'Azkar library is being prepared';

  @override
  String get quran_title => 'The Quran';

  @override
  String get quran_index_title => 'Surahs';

  @override
  String quran_surah_verse_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count verses',
      one: '1 verse',
    );
    return '$_temp0';
  }

  @override
  String get quran_revelation_meccan => 'Meccan';

  @override
  String get quran_revelation_medinan => 'Medinan';

  @override
  String get quran_loading => 'Loading';

  @override
  String get quran_error => 'Failed to load';

  @override
  String get quran_retry => 'Retry';

  @override
  String get quran_attribution => 'Source: Tanzil.net';

  @override
  String get verse_actions_copy => 'Copy';

  @override
  String get verse_actions_share => 'Share';

  @override
  String get verse_actions_cancel => 'Cancel';

  @override
  String get verse_actions_copied => 'Copied';
}
