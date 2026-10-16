import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/quran/application/quran_providers.dart';

import 'quran_test_helpers.dart';

void main() {
  ProviderContainer containerWithStubs() {
    final container = ProviderContainer(
      overrides: [
        quranRepositoryOverride(
          fakeQuranRepository([stubSurah(), stubSurah(id: 2, verses: 3)]),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('quranIndexProvider', () {
    test('emits the stub index (keepAlive)', () async {
      final index = await containerWithStubs().read(
        quranIndexProvider.future,
      );
      expect(index.surahs, hasLength(2));
      expect(index.totalVerses, 5);
      expect(index.source, 'Tanzil.net');
    });

    test('emits the real 114-row index', () async {
      final container = ProviderContainer(
        overrides: [quranRepositoryOverride(realQuranRepository())],
      );
      addTearDown(container.dispose);
      final index = await container.read(quranIndexProvider.future);
      expect(index.surahs, hasLength(114));
      expect(index.totalVerses, 6236);
    });
  });

  group('surahProvider', () {
    test('returns the requested surah (family)', () async {
      final surah = await containerWithStubs().read(
        surahProvider(2).future,
      );
      expect(surah.id, 2);
      expect(surah.verses, hasLength(3));
    });

    test('surfaces an error for an unknown id', () async {
      await expectLater(
        containerWithStubs().read(surahProvider(115).future),
        throwsArgumentError,
      );
    });
  });
}
