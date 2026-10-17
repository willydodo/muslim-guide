import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/features/hijri/application/hijri_providers.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Month navigator row (previous / label / next).
class MonthNavigator extends ConsumerWidget {
  /// Creates the navigator.
  const new({required this.label, super.key});

  /// Localized month label.
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anchor = ref.watch(hijriMonthProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => ref
              .read(hijriMonthProvider.notifier)
              .state = DateTime(anchor.year, anchor.month - 1),
        ),
        Text(label, style: Theme.of(context).textTheme.titleLarge),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => ref
              .read(hijriMonthProvider.notifier)
              .state = DateTime(anchor.year, anchor.month + 1),
        ),
      ],
    );
  }
}

/// Adjustment stepper (-1 / 0 / +1) persisted in Hive settings.
class AdjustmentRow extends ConsumerWidget {
  /// Creates the stepper.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final adjustment = ref.watch(hijriAdjustmentProvider);
    final notifier = ref.read(hijriAdjustmentProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.hijri_adjustment_title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.s),
        SegmentedButton<int>(
          segments: [
            ButtonSegment(
              value: -1,
              label: Text(loc.hijri_adjustment_minus_one),
            ),
            ButtonSegment(value: 0, label: Text(loc.hijri_adjustment_none)),
            ButtonSegment(
              value: 1,
              label: Text(loc.hijri_adjustment_plus_one),
            ),
          ],
          selected: {adjustment},
          onSelectionChanged: (selected) =>
              notifier.setAdjustment(selected.first),
        ),
      ],
    );
  }
}

/// Error state with retry.
class CalendarError extends StatelessWidget {
  /// Creates an error view.
  const new({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    super.key,
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
