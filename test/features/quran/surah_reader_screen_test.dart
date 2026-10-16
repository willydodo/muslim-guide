import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/app/theme/app_typography.dart';
import 'package:muslim_guide/features/quran/data/quran_repository.dart';
import 'package:muslim_guide/features/quran/presentation/surah_reader_screen.dart';
import 'package:muslim_guide/features/quran/presentation/widgets/verse_actions_sheet.dart';

import 'quran_index_screen_test.dart'
    show buildQuranTestApp, failingQuranRepository, pumpIndex;
import 'quran_test_helpers.dart';

Future<void> pumpReader(
  WidgetTester tester, {
  required int surahId,
  required QuranRepository repository,
  Locale locale = const Locale('ar'),
}) async {
  await tester.pumpWidget(
    buildQuranTestApp(
      overrides: [quranRepositoryOverride(repository)],
      locale: locale,
      child: SurahReaderScreen(surahId: surahId),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('SurahReaderScreen', () {
    testWidgets('shows loading then Al-Fatiha Mushaf text', (tester) async {
      await tester.pumpWidget(
        buildQuranTestApp(
          overrides: [quranRepositoryOverride(realQuranRepository())],
          child: const SurahReaderScreen(surahId: 1),
        ),
      );
      expect(find.text('جاري التحميل'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('الفاتحة'), findsOneWidget);
      final richText = tester.widget<RichText>(find.byType(RichText).first);
      expect(richText.textDirection, TextDirection.rtl);
      expect(richText.textAlign, TextAlign.justify);
      final paragraph = richText.text.toPlainText();
      expect(paragraph, contains('\u06DD'));
    });

    testWidgets('shows error with retry', (tester) async {
      await pumpIndex(tester, repository: failingQuranRepository());
      expect(find.text('فشل التحميل'), findsOneWidget);
    });

    testWidgets('renders Al-Baqara without overflow', (tester) async {
      await pumpReader(
        tester,
        surahId: 2,
        repository: realQuranRepository(),
      );
      expect(tester.takeException(), isNull);
      final richText = tester.widget<RichText>(
        find.byKey(const ValueKey('mushaf-paragraph')),
      );
      expect(richText.text.toPlainText().length, greaterThan(1000));
    });

    testWidgets('uses the Amiri Quran style', (tester) async {
      await pumpReader(
        tester,
        surahId: 1,
        repository: fakeQuranRepository([stubSurah()]),
      );
      final richText = tester.widget<RichText>(find.byType(RichText).first);
      expect(richText.text.style?.fontFamily, AppTypography.quran.fontFamily);
      expect(richText.text.style?.fontSize, AppTypography.quran.fontSize);
    });

    testWidgets('tapping a verse opens the actions sheet', (tester) async {
      await pumpReader(
        tester,
        surahId: 1,
        repository: fakeQuranRepository([stubSurah()]),
      );
      final richText = tester.widget<RichText>(find.byType(RichText).first);
      final span = (richText.text as TextSpan).children!.first as TextSpan;
      final recognizer = span.recognizer! as TapGestureRecognizer;
      recognizer.onTap!();
      await tester.pumpAndSettle();
      expect(find.byType(VerseActionsSheet), findsOneWidget);
      expect(find.text('name-1 · 1'), findsOneWidget);
    });

    testWidgets('Surah 2 shows a separate basmala header', (tester) async {
      await pumpReader(
        tester,
        surahId: 2,
        repository: realQuranRepository(),
      );
      expect(find.byKey(MushafWithBasmala.basmalaKey), findsOneWidget);
    });

    testWidgets('Surah 1 does NOT show a separate basmala header', (
      tester,
    ) async {
      await pumpReader(
        tester,
        surahId: 1,
        repository: realQuranRepository(),
      );
      expect(find.byKey(MushafWithBasmala.basmalaKey), findsNothing);
    });

    testWidgets('Surah 9 shows no basmala header', (tester) async {
      await pumpReader(
        tester,
        surahId: 9,
        repository: realQuranRepository(),
      );
      expect(find.byKey(MushafWithBasmala.basmalaKey), findsNothing);
    });

    testWidgets('renders at 200% text scale without overflow', (
      tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: buildQuranTestApp(
            overrides: [
              quranRepositoryOverride(fakeQuranRepository([stubSurah()])),
            ],
            child: const SurahReaderScreen(surahId: 1),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('name-1'), findsOneWidget);
    });
  });
}
