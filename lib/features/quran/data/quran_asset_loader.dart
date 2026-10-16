import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/features/quran/domain/verse.dart';

/// Loads the bundled Uthmani Quran JSON and caches the parsed surahs.
///
/// Source: `assets/content/quran/quran-uthmani.json` (Tanzil, CC BY 3.0,
/// DEC-0030). The JSON payload is never modified — display enrichment only:
/// the loader derives the basmala text from Al-Fatiha verse 1 (so the exact
/// Uthmani glyph sequence always matches the asset) and exposes it as a
/// separate [Surah.basmala] header for surahs other than 1 and 9. A
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

  /// Returns all 114 surahs with their verses and basmala headers.
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
    return List<Surah>.unmodifiable(_withBasmala(surahs));
  }

  /// Enriches [surahs] with display basmala headers (JSON untouched).
  ///
  /// The basmala header is the first four whitespace-separated words of
  /// Al-Fatiha verse 1; surah 1 keeps it as verse 1, surah 9 (At-Tawba)
  /// gets none, and every other surah carries the header separately while
  /// its verse 1 keeps only the remaining words. Splitting on the first
  /// four words (not an exact full-string match) tolerates the Tanzil
  /// asset's own spelling variance — surahs 95 and 97 carry a shadda on
  /// the ba (U+0651) absent elsewhere — while a short verse 1 throws, so
  /// silent drift cannot ship.
  List<Surah> _withBasmala(List<Surah> surahs) {
    final fatiha = surahs.firstWhere((surah) => surah.id == 1);
    if (fatiha.verses.isEmpty) {
      throw const FormatException('Al-Fatiha must carry its verses.');
    }
    final canonicalBasmala = fatiha.verses.first.text;
    final canonicalTokens = canonicalBasmala.split(' ');
    if (canonicalTokens.length != 4) {
      throw const FormatException(
        'Al-Fatiha verse 1 must hold the four-word basmala.',
      );
    }
    return surahs.map((surah) {
      if (surah.id == 1) {
        return Surah(
          id: surah.id,
          nameAr: surah.nameAr,
          nameEn: surah.nameEn,
          verseCount: surah.verseCount,
          revelation: surah.revelation,
          order: surah.order,
          verses: surah.verses,
          basmala: canonicalBasmala,
        );
      }
      if (surah.id == 9) return surah;
      if (surah.verses.isEmpty) {
        throw FormatException(
          'Surah ${surah.id} must carry its verses for basmala splitting.',
        );
      }
      final first = surah.verses.first;
      final tokens = first.text.split(' ');
      if (tokens.length < 5) {
        throw FormatException(
          'Surah ${surah.id} verse 1 has no text after the basmala.',
        );
      }
      final header = tokens.take(4).join(' ');
      final rest = tokens.skip(4).join(' ').trim();
      if (rest.isEmpty) {
        throw FormatException(
          'Surah ${surah.id} verse 1 has no text after the basmala.',
        );
      }
      final verses = List<Verse>.unmodifiable([
        first.copyWith(text: rest),
        ...surah.verses.skip(1),
      ]);
      return Surah(
        id: surah.id,
        nameAr: surah.nameAr,
        nameEn: surah.nameEn,
        verseCount: surah.verseCount,
        revelation: surah.revelation,
        order: surah.order,
        verses: verses,
        basmala: header,
      );
    }).toList(growable: false);
  }
}
