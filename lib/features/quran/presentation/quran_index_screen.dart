import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/features/quran/application/quran_providers.dart';
import 'package:muslim_guide/features/quran/presentation/widgets/surah_list_item.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Quran index screen: 114 surahs with Tanzil attribution footer.
class QuranIndexScreen extends ConsumerWidget {
  /// Creates the index screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final indexAsync = ref.watch(quranIndexProvider);
    return Scaffold(
      appBar: AppBar(title: Text(loc.quran_title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: indexAsync.when(
                loading: () => Center(child: Text(loc.quran_loading)),
                error:
                    (error, stackTrace) => _IndexError(
                      message: loc.quran_error,
                      retryLabel: loc.quran_retry,
                      onRetry: () => ref.invalidate(quranIndexProvider),
                    ),
                data:
                    (index) => ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.l),
                      itemCount: index.surahs.length,
                      separatorBuilder:
                          (context, index) =>
                              const SizedBox(height: AppSpacing.s),
                      itemBuilder: (context, position) {
                        final summary = index.surahs[position];
                        return SurahListItem(
                          summary: summary,
                          onTap:
                              () => context.push('/quran/surah/${summary.id}'),
                        );
                      },
                    ),
              ),
            ),
            _AttributionFooter(label: loc.quran_attribution),
          ],
        ),
      ),
    );
  }
}

/// License attribution footer (CC BY 3.0 requirement, Tanzil source).
class _AttributionFooter extends StatelessWidget {
  /// Creates the footer.
  const new({required this.label});

  /// Localized attribution label.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Error state with retry.
class _IndexError extends StatelessWidget {
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
