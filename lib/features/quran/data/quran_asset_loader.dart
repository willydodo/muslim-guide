import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';

/// Loads the bundled Uthmani Quran JSON and caches the parsed surahs.
///
/// Source: `assets/content/quran/quran-uthmani.json` (Tanzil, CC BY 3.0,
/// DEC-0030). Verse text is never modified — it is parsed verbatim, so a
/// malformed asset throws instead of rendering partial content.
class QuranAssetLoader {
  /// Creates a loader for the supplied asset bundle.
  new({
    required this.assetBundle,
    this.assetPath = 'assets/content/quran/quran-uthmani.json',
  });

  /// Bundled JSON path.
  final String assetPath;

  /// Asset bundle used to load the JSON file.
  final AssetBundle assetBundle;

  Future<List<Surah>>? _cache;

  /// Returns all 114 surahs with their verses, parsed verbatim.
  Future<List<Surah>> load() {
    return _cache ??= _load();
  }

  Future<List<Surah>> _load() async {
    final raw = await assetBundle.loadString(assetPath);
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Quran asset root must be a JSON object.');
    }
    final rawSurahs = decoded['surahs'];
    if (rawSurahs is! List<dynamic>) {
      throw const FormatException(
        'Quran asset field "surahs" must be a list.',
      );
    }
    if (rawSurahs.length != 114) {
      throw FormatException(
        'Quran asset must contain 114 surahs, found ${rawSurahs.length}.',
      );
    }
    final surahs = <Surah>[];
    for (final rawSurah in rawSurahs) {
      if (rawSurah is! Map<String, dynamic>) {
        throw const FormatException('Each surah must be a JSON object.');
      }
      surahs.add(Surah.fromJson(rawSurah));
    }
    return List<Surah>.unmodifiable(surahs);
  }
}
