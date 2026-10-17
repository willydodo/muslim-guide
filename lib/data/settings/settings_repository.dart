import 'package:hive_ce/hive.dart';
import 'package:muslim_guide/features/notifications/domain/prayer_notification.dart';
import 'package:muslim_guide/features/prayer/domain/models/asr_method.dart';
import 'package:muslim_guide/features/prayer/domain/models/calculation_method.dart';
import 'package:muslim_guide/features/prayer/domain/models/high_latitude_rule.dart';

/// Reads and writes persisted application settings.
class SettingsRepository {
  /// Creates a repository backed by a Hive settings box.
  new(this._settingsBox);

  final Box<dynamic>? _settingsBox;

  /// Returns the saved language, or Arabic when no value is stored.
  Future<String> getLanguage() async {
    final value = _boxOrNull?.get('language', defaultValue: 'ar') ?? 'ar';
    if (value is! String || (value != 'ar' && value != 'en')) {
      throw FormatException('Invalid stored language value: $value');
    }
    return value;
  }

  /// Saves the interface language.
  Future<void> setLanguage(String language) async {
    if (language != 'ar' && language != 'en') {
      throw ArgumentError.value(language, 'language', 'Expected "ar" or "en".');
    }
    await _box.put('language', language);
  }

  /// Returns whether onboarding has been completed.
  Future<bool> isOnboardingCompleted() async {
    final value =
        _boxOrNull?.get('onboarding_completed', defaultValue: false) ?? false;
    if (value is! bool) {
      throw FormatException(
        'Invalid stored onboarding_completed value: $value',
      );
    }
    return value;
  }

  /// Saves whether onboarding has been completed.
  // ignore: avoid_positional_boolean_parameters // Keep the documented bool setter API.
  Future<void> setOnboardingCompleted(bool completed) async {
    await _box.put('onboarding_completed', completed);
  }

  /// Returns the saved theme, or system when no value is stored.
  Future<String> getTheme() async {
    final value = _boxOrNull?.get('theme', defaultValue: 'system') ?? 'system';
    if (value is! String ||
        (value != 'light' && value != 'dark' && value != 'system')) {
      throw FormatException('Invalid stored theme value: $value');
    }
    return value;
  }

  /// Saves the selected theme.
  Future<void> setTheme(String theme) async {
    if (theme != 'light' && theme != 'dark' && theme != 'system') {
      throw ArgumentError.value(
        theme,
        'theme',
        'Expected "light", "dark", or "system".',
      );
    }
    await _box.put('theme', theme);
  }

  /// Returns the saved manually selected city ID, or null when unset.
  Future<String?> getSelectedCityId() async {
    final value = _boxOrNull?.get('selected_city_id');
    if (value == null) {
      return null;
    }
    if (value is! String || value.trim().isEmpty) {
      throw FormatException(
        'Invalid stored selected_city_id value: $value',
      );
    }
    return value;
  }

  /// Saves the manually selected city ID; null clears the selection.
  Future<void> setSelectedCityId(String? cityId) async {
    if (cityId == null) {
      await _box.delete('selected_city_id');
      return;
    }
    if (cityId.trim().isEmpty) {
      throw ArgumentError.value(
        cityId,
        'cityId',
        'Expected a non-empty city ID.',
      );
    }
    await _box.put('selected_city_id', cityId);
  }

  /// Returns the saved GPS coordinates, or null when unset.
  Future<(double, double)?> getSelectedCoordinates() async {
    final value = _boxOrNull?.get('selected_coordinates');
    if (value == null) {
      return null;
    }
    if (value is! String) {
      throw FormatException(
        'Invalid stored selected_coordinates value: $value',
      );
    }
    final parts = value.split(',');
    if (parts.length != 2) {
      throw FormatException(
        'Stored selected_coordinates must be "latitude,longitude": $value',
      );
    }
    final latitude = double.tryParse(parts[0]);
    final longitude = double.tryParse(parts[1]);
    if (latitude == null ||
        longitude == null ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      throw FormatException(
        'Stored selected_coordinates out of range: $value',
      );
    }
    return (latitude, longitude);
  }

  /// Saves the GPS coordinates; null/null clears the selection.
  Future<void> setSelectedCoordinates(
    double? latitude,
    double? longitude,
  ) async {
    if (latitude == null && longitude == null) {
      await _box.delete('selected_coordinates');
      return;
    }
    if (latitude == null || longitude == null) {
      throw ArgumentError(
        'Both latitude and longitude must be provided together.',
      );
    }
    if (latitude < -90 || latitude > 90) {
      throw ArgumentError.value(
        latitude,
        'latitude',
        'Expected a value between -90 and 90.',
      );
    }
    if (longitude < -180 || longitude > 180) {
      throw ArgumentError.value(
        longitude,
        'longitude',
        'Expected a value between -180 and 180.',
      );
    }
    await _box.put('selected_coordinates', '$latitude,$longitude');
  }

  /// Returns the saved calculation method, or MWL (DEC-0028).
  Future<CalculationMethod> getCalculationMethod() async {
    final value =
        _boxOrNull?.get('calculation_method') ?? CalculationMethod.mwl.name;
    if (value is! String) {
      throw FormatException(
        'Invalid stored calculation_method value: $value',
      );
    }
    for (final method in CalculationMethod.values) {
      if (method.name == value) {
        return method;
      }
    }
    throw FormatException('Invalid stored calculation_method value: $value');
  }

  /// Saves the selected calculation method.
  ///
  /// [markExplicit] records that the user chose the method deliberately
  /// (manual Settings change or SnackBar Undo). Auto-apply from country
  /// detection passes `false` so the method stays implicit.
  Future<void> setCalculationMethod(
    CalculationMethod method, {
    bool markExplicit = true,
  }) async {
    await _box.put('calculation_method', method.name);
    if (markExplicit) {
      await _box.put('calculation_method_explicit', true);
    }
  }

  /// Whether the user has ever chosen a calculation method deliberately.
  ///
  /// Absence of the key means implicit (Phase 05-B country auto-apply).
  Future<bool> isCalculationMethodExplicit() async {
    return _boxOrNull?.get('calculation_method_explicit') == true;
  }

  /// Returns the saved Asr method, or Standard (DEC-0028).
  Future<AsrMethod> getAsrMethod() async {
    final value = _boxOrNull?.get('asr_method') ?? AsrMethod.standard.name;
    if (value is! String) {
      throw FormatException('Invalid stored asr_method value: $value');
    }
    for (final asrMethod in AsrMethod.values) {
      if (asrMethod.name == value) {
        return asrMethod;
      }
    }
    throw FormatException('Invalid stored asr_method value: $value');
  }

  /// Saves the selected Asr method.
  Future<void> setAsrMethod(AsrMethod asrMethod) async {
    await _box.put('asr_method', asrMethod.name);
  }

  /// Returns the saved high-latitude rule, or MiddleOfNight (DEC-0028).
  Future<HighLatitudeRule> getHighLatitudeRule() async {
    final value =
        _boxOrNull?.get('high_latitude_rule') ??
        HighLatitudeRule.middleOfNight.name;
    if (value is! String) {
      throw FormatException(
        'Invalid stored high_latitude_rule value: $value',
      );
    }
    for (final rule in HighLatitudeRule.values) {
      if (rule.name == value) {
        return rule;
      }
    }
    throw FormatException(
      'Invalid stored high_latitude_rule value: $value',
    );
  }

  /// Saves the selected high-latitude rule.
  Future<void> setHighLatitudeRule(HighLatitudeRule rule) async {
    await _box.put('high_latitude_rule', rule.name);
  }

  /// Returns the prayers with notifications enabled (Task 7).
  ///
  /// Absence of the key means all five prayers are enabled (SETTING-006).
  /// Unknown stored names are ignored (forward tolerance).
  Future<Set<PrayerNotification>> getEnabledPrayerNotifications() async {
    final value = _boxOrNull?.get('enabled_prayer_notifications');
    if (value == null) {
      return PrayerNotification.values.toSet();
    }
    if (value is! List) {
      throw FormatException(
        'Invalid stored enabled_prayer_notifications value: $value',
      );
    }
    final enabled = <PrayerNotification>{};
    for (final entry in value) {
      if (entry is! String) {
        throw FormatException(
          'Invalid stored enabled_prayer_notifications entry: $entry',
        );
      }
      for (final prayer in PrayerNotification.values) {
        if (prayer.name == entry) {
          enabled.add(prayer);
        }
      }
    }
    return enabled;
  }

  /// Saves the prayers with notifications enabled (Task 7).
  ///
  /// An empty set disables all prayer notifications; the scheduler then
  /// produces an empty schedule.
  Future<void> setEnabledPrayerNotifications(
    Set<PrayerNotification> prayers,
  ) async {
    final names = prayers.map((prayer) => prayer.name).toList()..sort();
    await _box.put('enabled_prayer_notifications', names);
  }

  /// Returns the saved Hijri date adjustment in days (-1, 0, +1),
  /// or 0 when unset (REQ-HIJRI-001, DEC-0033).
  Future<int> getHijriAdjustment() async {
    final value = _boxOrNull?.get('hijri_adjustment', defaultValue: 0) ?? 0;
    if (value is! int || value < -1 || value > 1) {
      throw FormatException('Invalid stored hijri_adjustment value: $value');
    }
    return value;
  }

  /// Saves the Hijri date adjustment in days (-1, 0, +1).
  Future<void> setHijriAdjustment(int adjustment) async {
    if (adjustment < -1 || adjustment > 1) {
      throw ArgumentError.value(
        adjustment,
        'adjustment',
        'Expected -1, 0, or +1.',
      );
    }
    await _box.put('hijri_adjustment', adjustment);
  }

  Box<dynamic>? get _boxOrNull =>
      (_settingsBox?.isOpen ?? false) ? _settingsBox : null;

  Box<dynamic> get _box =>
      _boxOrNull ?? (throw StateError('Hive settings storage is unavailable.'));
}
