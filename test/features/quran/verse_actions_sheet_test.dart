import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/features/quran/domain/verse.dart';
import 'package:muslim_guide/features/quran/presentation/widgets/verse_actions_sheet.dart';

import 'quran_index_screen_test.dart' show buildQuranTestApp;

Widget pumpSheet({
  Surah? surah,
  Verse? verse,
  Future<void> Function(String text)? shareText,
}) {
  final resolvedSurah =
      surah ??
      // ignore: prefer_const_constructors // Verse uses the project const new(...) mandate, so its constructor is non-const and Surah cannot be const here.
      Surah(
        id: 1,
        nameAr: 'name-1',
        nameEn: 'Name 1',
        verseCount: 1,
        revelation: RevelationType.meccan,
        order: 1,
        verses: const [Verse(surahId: 1, number: 1, text: 'text-0')],
      );
  return buildQuranTestApp(
    child: Scaffold(
      body: Builder(
        builder:
            (context) => FilledButton(
              onPressed:
                  () => showModalBottomSheet<void>(
                    context: context,
                    builder:
                        (_) => VerseActionsSheet(
                          surah: resolvedSurah,
                          verse: verse ?? resolvedSurah.verses.first,
                          shareText: shareText ?? ((_) async {}),
                        ),
                  ),
              child: const Text('open'),
            ),
      ),
    ),
  );
}

void main() {
  group('VerseActionsSheet', () {
    test('formats the verse with attribution', () {
      const surah = Surah(
        id: 1,
        nameAr: 'name-1',
        nameEn: 'Name 1',
        verseCount: 1,
        revelation: RevelationType.meccan,
        order: 1,
        verses: [Verse(surahId: 1, number: 1, text: 'text-0')],
      );
      expect(
        VerseActionsSheet.formatVerse(surah, surah.verses.first),
        'text-0\n[name-1: 1]',
      );
    });

    testWidgets('shows copy, share, and cancel rows', (tester) async {
      await tester.pumpWidget(pumpSheet());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('نسخ'), findsOneWidget);
      expect(find.text('مشاركة'), findsOneWidget);
      expect(find.text('إلغاء'), findsOneWidget);
      expect(find.text('name-1 · 1'), findsOneWidget);
    });

    testWidgets('copy writes the clipboard and confirms', (tester) async {
      String? clipboardText;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (
            call,
          ) async {
            if (call.method == 'Clipboard.setData') {
              final args = call.arguments as Map<dynamic, dynamic>;
              clipboardText = args['text'] as String?;
            }
            return null;
          });
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, null);
      });
      await tester.pumpWidget(pumpSheet());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('نسخ'));
      await tester.pumpAndSettle();
      expect(clipboardText, 'text-0\n[name-1: 1]');
      expect(find.byType(VerseActionsSheet), findsNothing);
    });

    testWidgets('share forwards the formatted text', (tester) async {
      String? shared;
      await tester.pumpWidget(
        pumpSheet(
          shareText: (text) async {
            shared = text;
          },
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('مشاركة'));
      await tester.pumpAndSettle();
      expect(shared, 'text-0\n[name-1: 1]');
      expect(find.byType(VerseActionsSheet), findsNothing);
    });

    testWidgets('cancel closes the sheet', (tester) async {
      await tester.pumpWidget(pumpSheet());
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('إلغاء'));
      await tester.pumpAndSettle();
      expect(find.byType(VerseActionsSheet), findsNothing);
    });
  });
}
