import 'package:flutter/material.dart';

/// Typography tokens used throughout the application.
class AppTypography {
  new _();

  /// Default Material text styles for both theme modes.
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  );

  /// Style for Quranic text (Amiri Quran font), not interface text.
  static const TextStyle quran = TextStyle(
    fontFamily: 'AmiriQuran',
    fontSize: 28,
    height: 2,
    letterSpacing: 0,
  );

  /// Style for surah names in the index (Amiri Quran, Phase 06 Task 2).
  static const TextStyle surahName = TextStyle(
    fontFamily: 'AmiriQuran',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}
