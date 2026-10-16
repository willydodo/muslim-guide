import 'package:flutter/material.dart';
import 'package:muslim_guide/app/theme/app_typography.dart';
import 'package:muslim_guide/features/quran/data/quran_repository.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// One surah row in the Quran index (48dp target, semantics label).
class SurahListItem extends StatelessWidget {
  /// Creates a surah row.
  const new({required this.summary, required this.onTap, super.key});

  /// Surah metadata (no verse text).
  final SurahSummary summary;

  /// Invoked on tap.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final revelationText =
        summary.revelation == RevelationType.meccan
            ? loc.quran_revelation_meccan
            : loc.quran_revelation_medinan;
    return Semantics(
      button: true,
      label:
          '${summary.nameAr}, '
          '${loc.quran_surah_verse_count(summary.verseCount)}',
      child: SizedBox(
        height: 72,
        child: ListTile(
          leading: CircleAvatar(child: Text('${summary.id}')),
          title: Text(summary.nameAr, style: AppTypography.surahName),
          subtitle: Text(
            '$revelationText · '
            '${loc.quran_surah_verse_count(summary.verseCount)}',
          ),
          trailing: const Icon(Icons.chevron_left),
          onTap: onTap,
        ),
      ),
    );
  }
}
