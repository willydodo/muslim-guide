import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/quran/data/quran_asset_loader.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/features/quran/domain/verse.dart';

/// Asset bundle serving [payload] for any requested key.
class FakeQuranAssetBundle extends CachingAssetBundle {
  /// Creates a bundle answering with [payload].
  /// Plain form required: `const new(...)` errors on the non-const super.
  // ignore: unnecessary_type_name_in_constructor // Plain form required: const new(...) errors on the non-const CachingAssetBundle super.
  FakeQuranAssetBundle(this.payload);

  /// JSON payload served for every load.
  final String payload;

  @override
  Future<ByteData> load(String key) async {
    return ByteData.sublistView(utf8.encode(payload));
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return payload;
  }
}

/// Reads the real bundled asset from disk (never rewritten from memory).
String realAssetPayload() {
  return File('assets/content/quran/quran-uthmani.json').readAsStringSync();
}

Map<String, dynamic> validSurah() {
  return {
    'id': 1,
    'name_ar': 'الفاتحة',
    'name_en': 'The Opening',
    'verse_count': 2,
    'revelation': 'meccan',
    'order': 5,
    'verses': [
      {'id': 1, 'text': 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ'},
      {'id': 2, 'text': 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ'},
    ],
  };
}

void main() {
  group('Verse.fromJson', () {
    test('parses surah id, number, and verbatim text', () {
      final verse = Verse.fromJson(
        {'id': 3, 'text': 'sample-text'},
        surahId: 2,
      );
      expect(verse.surahId, 2);
      expect(verse.number, 3);
      expect(verse.text, 'sample-text');
    });

    test('throws on non-positive id', () {
      expect(
        () => Verse.fromJson({'id': 0, 'text': 'x'}, surahId: 1),
        throwsFormatException,
      );
    });

    test('throws on empty text', () {
      expect(
        () => Verse.fromJson({'id': 1, 'text': ''}, surahId: 1),
        throwsFormatException,
      );
    });
  });

  group('Surah.fromJson', () {
    test('parses metadata and sequential verses', () {
      final surah = Surah.fromJson(validSurah());
      expect(surah.id, 1);
      expect(surah.verseCount, 2);
      expect(surah.verses, hasLength(2));
      expect(surah.revelation, RevelationType.meccan);
      expect(surah.order, 5);
    });

    test('throws when verse_count mismatches the verses list', () {
      final raw = validSurah()..['verse_count'] = 7;
      expect(() => Surah.fromJson(raw), throwsFormatException);
    });

    test('throws on unknown revelation value', () {
      final raw = validSurah()..['revelation'] = 'unknown';
      expect(() => Surah.fromJson(raw), throwsFormatException);
    });

    test('throws on non-sequential verse numbers', () {
      final raw = validSurah();
      raw['verses'] = [
        {'id': 1, 'text': 'a'},
        {'id': 3, 'text': 'b'},
      ];
      expect(() => Surah.fromJson(raw), throwsFormatException);
    });
  });

  group('QuranAssetLoader (real asset)', () {
    test('loads 114 surahs and 6236 verses', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      final surahs = await loader.load();
      expect(surahs, hasLength(114));
      final total = surahs.fold<int>(0, (sum, surah) {
        return sum + surah.verses.length;
      });
      expect(total, 6236);
    });

    test('Al-Fatiha carries 7 verses', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      final surahs = await loader.load();
      final fatiha = surahs.firstWhere((surah) => surah.id == 1);
      expect(fatiha.verseCount, 7);
      expect(fatiha.verses, hasLength(7));
    });

    test('asset text preserved (basmala + verses rebuild verse 1)', () async {
      final payload = realAssetPayload();
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(payload),
      );
      final surahs = await loader.load();
      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      final rawSurahs = decoded['surahs'] as List<dynamic>;
      for (var i = 0; i < surahs.length; i++) {
        final rawVerses =
            (rawSurahs[i] as Map<String, dynamic>)['verses'] as List<dynamic>;
        for (var j = 0; j < surahs[i].verses.length; j++) {
          final rawText = (rawVerses[j] as Map<String, dynamic>)['text'];
          if (surahs[i].id == 1 || surahs[i].id == 9 || j > 0) {
            expect(surahs[i].verses[j].text, rawText);
          } else {
            expect(
              '${surahs[i].basmala} ${surahs[i].verses[j].text}',
              rawText,
            );
          }
        }
      }
    });

    test('Surah 1 (Al-Fatiha) — basmala is verse 1', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      final surahs = await loader.load();
      final surah = surahs.firstWhere((item) => item.id == 1);
      expect(surah.basmala, isNotNull);
      expect(surah.verses.first.text, contains('بِسْمِ'));
      expect(surah.basmala, surah.verses.first.text);
      expect(surah.verseCount, 7);
      expect(surah.verses, hasLength(7));
    });

    test('Surah 2 (Al-Baqara) — basmala separated', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      final surahs = await loader.load();
      final surah = surahs.firstWhere((item) => item.id == 2);
      expect(surah.basmala, isNotNull);
      expect(surah.basmala, contains('بِسْمِ'));
      expect(surah.verses.first.text, isNot(startsWith('بِسْمِ')));
      expect(surah.verses.first.text, startsWith('الٓمٓ'));
      expect(surah.verseCount, 286);
      expect(surah.verses, hasLength(286));
    });

    test('Surah 9 (At-Tawba) — no basmala', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      final surahs = await loader.load();
      final surah = surahs.firstWhere((item) => item.id == 9);
      expect(surah.basmala, isNull);
    });

    test('all surahs except 1 and 9 carry the basmala', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      final surahs = await loader.load();
      for (final surah in surahs) {
        if (surah.id == 1 || surah.id == 9) continue;
        expect(surah.basmala, isNotNull, reason: 'Surah ${surah.id}');
        expect(
          surah.verses.first.text,
          isNot(startsWith('بِسْمِ')),
          reason: 'Surah ${surah.id}',
        );
      }
    });

    test('caches the parsed result', () async {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle(realAssetPayload()),
      );
      expect(await loader.load(), same(await loader.load()));
    });

    test('throws on invalid JSON', () {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle('not json'),
      );
      expect(loader.load(), throwsFormatException);
    });

    test('throws when surah count is not 114', () {
      final loader = QuranAssetLoader(
        assetBundle: FakeQuranAssetBundle('{"surahs": []}'),
      );
      expect(loader.load(), throwsFormatException);
    });
  });
}
