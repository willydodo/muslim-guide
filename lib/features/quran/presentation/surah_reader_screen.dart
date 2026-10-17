import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/app/theme/app_typography.dart';
import 'package:muslim_guide/features/quran/application/quran_providers.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/features/quran/domain/verse.dart';
import 'package:muslim_guide/features/quran/presentation/widgets/verse_actions_sheet.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Surah reader screen: connected Mushaf text, RTL, Amiri Quran font.
///
/// Each verse is one [TextSpan] with a [TapGestureRecognizer] opening the
/// verse actions sheet (Phase 06 Task 2 decision: RichText + TextSpan).
class SurahReaderScreen extends ConsumerWidget {
  /// Creates the reader screen.
  const new({required this.surahId, super.key});

  /// Surah id (1-114, validated by the router).
  final int surahId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final surahAsync = ref.watch(surahProvider(surahId));
    return Scaffold(
      appBar: AppBar(
        title: surahAsync.maybeWhen(
          data:
              (surah) => Text(surah.nameAr, style: AppTypography.surahName),
          orElse: () => Text(loc.quran_title),
        ),
      ),
      body: SafeArea(
        child: surahAsync.when(
          loading: () => Center(child: Text(loc.quran_loading)),
          error:
              (error, stackTrace) => _ReaderError(
                message: loc.quran_error,
                retryLabel: loc.quran_retry,
                onRetry: () => ref.invalidate(surahProvider(surahId)),
              ),
          data: (surah) => MushafWithBasmala(surah: surah),
        ),
      ),
    );
  }
}

/// Mushaf paragraph with the display basmala header.
///
/// Surah 1 (basmala is verse 1) and surah 9 (no basmala) render the
/// connected verses inline; every other surah shows [Surah.basmala] as a
/// centered header above the verses inside the same scroll view so the
/// header scrolls away with the text.
class MushafWithBasmala extends StatefulWidget {
  /// Creates the basmala wrapper.
  const new({required this.surah, super.key});

  /// Surah rendered below the header.
  final Surah surah;

  /// Testing key for the separate basmala header.
  static const basmalaKey = ValueKey<String>('basmala-header');

  @override
  State<MushafWithBasmala> createState() => _MushafWithBasmalaState();
}

/// State holding the per-verse tap recognizers (option A + dispose).
class _MushafWithBasmalaState extends State<MushafWithBasmala> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
  }

  void _onVerseTap(Verse verse) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (_) => VerseActionsSheet(surah: widget.surah, verse: verse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final surah = widget.surah;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final showBasmala =
        surah.id != 1 && surah.id != 9 && surah.basmala != null;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showBasmala)
            Padding(
              key: MushafWithBasmala.basmalaKey,
              padding: const EdgeInsets.only(bottom: AppSpacing.l),
              child: Text(
                surah.basmala!,
                style: AppTypography.quran.copyWith(color: textColor),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          Semantics(
            label: '${surah.nameAr}, ${surah.verses.length}',
            child: RichText(
              key: const ValueKey('mushaf-paragraph'),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: AppTypography.quran.copyWith(color: textColor),
                children:
                    surah.verses.map((verse) {
                      final recognizer =
                          TapGestureRecognizer()
                            ..onTap = () => _onVerseTap(verse);
                      _recognizers.add(recognizer);
                      // Mushaf end marker (U+06DD) + Arabic-Indic verse
                      // number, e.g. "۝١". Verbatim verse text untouched.
                      return TextSpan(
                        text:
                            '${verse.text} '
                            '\u06DD${_toArabicIndic(verse.number)} ',
                        recognizer: recognizer,
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Converts [n] to Arabic-Indic digits (٠١٢٣٤٥٦٧٨٩), as printed in Mushafs.
String _toArabicIndic(int n) {
  const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return n.toString().split('').map((d) => digits[int.parse(d)]).join();
}

/// Error state with retry.
class _ReaderError extends StatelessWidget {
  /// Creates an error view.
  const new({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  /// Error message.
  final String message;

  /// Retry label.
  final String retryLabel;

  /// Retry callback.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: AppSpacing.m),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.l),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: onRetry,
              child: Text(retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
