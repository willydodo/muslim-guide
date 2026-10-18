import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/features/tasbih/application/tasbih_providers.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Tasbih list screen: two sections, or pending-pack Empty state.
class TasbihListScreen extends ConsumerWidget {
  /// Creates the list screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final packAsync = ref.watch(tasbihListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tasbih_list_title),
      ),
      body: SafeArea(
        child: packAsync.when(
          loading: () =>
              Center(child: Text(localizations.tasbih_list_loading)),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(localizations.tasbih_list_error,
                      textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.l),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () => ref.invalidate(tasbihListProvider),
                    child: Text(localizations.azkar_retry),
                  ),
                ],
              ),
            ),
          ),
          data: (pack) {
            if (pack == null || pack.entries.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.l),
                  child: Text(localizations.tasbih_empty_pending_pack,
                      textAlign: TextAlign.center),
                ),
              );
            }
            final afterPrayer = pack.entriesFor('after_prayer');
            final free = pack.entriesFor('free');
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                if (afterPrayer.isNotEmpty)
                  _SectionHeader(
                      title: localizations.tasbih_section_after_prayer),
                for (final entry in afterPrayer)
                  _EntryRow(
                    title: entry.dhikr,
                    subtitle:
                        '${entry.target} — ${entry.grade}',
                    onTap: () => context.go('/tasbih/${entry.id}'),
                  ),
                if (free.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.l),
                  _SectionHeader(
                      title: localizations.tasbih_section_free),
                  for (final entry in free)
                    _EntryRow(
                      title: entry.dhikr,
                      subtitle:
                          '${entry.target} — ${entry.grade}',
                      onTap: () => context.go('/tasbih/${entry.id}'),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Section header label.
class _SectionHeader extends StatelessWidget {
  /// Creates a section header.
  const new({required this.title});

  /// Header text.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// One tasbih entry row (48dp target, semantics label).
class _EntryRow extends StatelessWidget {
  /// Creates an entry row.
  const new({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  /// Dhikr title.
  final String title;

  /// Target + grade subtitle.
  final String subtitle;

  /// Opens the counter screen.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: title,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: ListTile(
          title: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
