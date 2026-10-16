import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/quran/data/quran_repository.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';

import 'quran_test_helpers.dart';

void main() {
  group('SurahSummary.fromSurah', () {
    test('copies metadata without verses', () {
      final summary = SurahSummary.fromSurah(stubSurah(id: 2, verses: 3));
      expect(summary.id, 2);
      expect(summary.verseCount, 3);
      expect(summary.revelation, RevelationType.meccan);
    });
  });

  group('QuranRepository.getIndex (real asset)', () {
    test('returns 114 metadata rows and 6236 total verses', () async {
      final index = await realQuranRepository().getIndex();
      expect(index.surahs, hasLength(114));
      expect(index.totalVerses, 6236);
      expect(index.source, 'Tanzil.net');
      expect(index.license, 'CC BY 3.0');
    });

    test('first row matches Al-Fatiha metadata', () async {
      final index = await realQuranRepository().getIndex();
      final first = index.surahs.first;
      expect(first.id, 1);
      expect(first.nameAr, 'الفاتحة');
      expect(first.verseCount, 7);
    });
  });

  group('QuranRepository.getSurah', () {
    test('returns the surah with its verses (real asset)', () async {
      final surah = await realQuranRepository().getSurah(1);
      expect(surah.id, 1);
      expect(surah.verses, hasLength(7));
    });

    test('Surah 1 — basmala is verse 1', () async {
      final surah = await realQuranRepository().getSurah(1);
      expect(surah.basmala, surah.verses.first.text);
      expect(surah.verseCount, 7);
      expect(surah.verses, hasLength(7));
    });

    test('Surah 2 — basmala separated in data', () async {
      final surah = await realQuranRepository().getSurah(2);
      expect(surah.basmala, isNotNull);
      expect(surah.verses.first.text, startsWith('الٓمٓ'));
      expect(surah.verseCount, 286);
      expect(surah.verses, hasLength(286));
    });

    test('Surah 9 — no basmala', () async {
      final surah = await realQuranRepository().getSurah(9);
      expect(surah.basmala, isNull);
    });

    test('returns a stub surah from the fake repository', () async {
      final surah = await fakeQuranRepository([stubSurah()]).getSurah(1);
      expect(surah.verses, hasLength(2));
    });

    test('throws ArgumentError for an unknown id', () async {
      final repository = fakeQuranRepository([stubSurah()]);
      await expectLater(repository.getSurah(0), throwsArgumentError);
      await expectLater(repository.getSurah(115), throwsArgumentError);
    });
  });
}
