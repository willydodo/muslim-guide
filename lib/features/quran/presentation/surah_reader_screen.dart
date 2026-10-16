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
          data: (surah) => _MushafPage(surah: surah),
        ),
      ),
    );
  }
}

/// Connected Mushaf paragraph (option A: recognizers + dispose).
class _MushafPage extends StatefulWidget {
  /// Creates the Mushaf page.
  const new({required this.surah});

  /// Surah rendered as one continuous RTL paragraph.
  final Surah surah;

  @override
  State<_MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends State<_MushafPage> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Semantics(
        label:
            '${widget.surah.nameAr}, '
            '${widget.surah.verses.length}',
        child: RichText(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: AppTypography.quran.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children:
                widget.surah.verses.map((verse) {
                  final recognizer =
                      TapGestureRecognizer()..onTap = () => _onVerseTap(verse);
                  _recognizers.add(recognizer);
                  // Verse-end marker only (U+06DD); verbatim text untouched.
                  return TextSpan(
                    text: '${verse.text} \u06DD ',
                    recognizer: recognizer,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
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
