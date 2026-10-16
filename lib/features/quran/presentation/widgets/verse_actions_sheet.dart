import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_guide/app/theme/app_typography.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/features/quran/domain/verse.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

/// Bottom sheet with copy/share actions for one verse.
///
/// Receives [shareText] for injection so widget tests can capture the
/// shared text without invoking the platform channel.
class VerseActionsSheet extends StatelessWidget {
  /// Creates the sheet.
  const new({
    required this.surah,
    required this.verse,
    this.shareText = _defaultShare,
    super.key,
  });

  /// Owning surah (name shown in the header and the copied text).
  final Surah surah;

  /// Verse the actions apply to.
  final Verse verse;

  /// Share invoker (defaults to SharePlus, overridden in tests).
  final Future<void> Function(String text) shareText;

  /// Formats the verse for copy/share (verbatim text + attribution).
  static String formatVerse(Surah surah, Verse verse) {
    return '${verse.text}\n[${surah.nameAr}: ${verse.number}]';
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SafeArea(
      child: Wrap(
        children: [
          Semantics(
            header: true,
            child: ListTile(
              title: Text(
                '${surah.nameAr} · ${verse.number}',
                style: AppTypography.surahName,
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.copy),
            title: Text(loc.verse_actions_copy),
            onTap: () => copyVerse(context),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text(loc.verse_actions_share),
            onTap: () => shareVerse(context),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: Text(loc.verse_actions_cancel),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// Copies the verse, closes the sheet, and confirms with a SnackBar.
  Future<void> copyVerse(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: formatVerse(surah, verse)));
    if (context.mounted) {
      final messenger = ScaffoldMessenger.of(context);
      final loc = AppLocalizations.of(context)!;
      Navigator.pop(context);
      messenger.showSnackBar(SnackBar(content: Text(loc.verse_actions_copied)));
    }
  }

  /// Shares the verse, then closes the sheet.
  Future<void> shareVerse(BuildContext context) async {
    await shareText(formatVerse(surah, verse));
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

/// Default share via SharePlus (share_plus 13.x instance API).
Future<void> _defaultShare(String text) {
  return SharePlus.instance.share(ShareParams(text: text));
}
