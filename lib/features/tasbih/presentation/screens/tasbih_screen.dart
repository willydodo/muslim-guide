import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/features/tasbih/application/tasbih_providers.dart';
import 'package:muslim_guide/features/tasbih/presentation/widgets/circular_counter.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Tasbih counter screen: progress ring + tap + reset (E-2/E-3).
class TasbihScreen extends ConsumerWidget {
  /// Creates the counter screen.
  const new({required this.entryId, super.key});

  /// Entry id from the route (`/tasbih/:id`).
  final String entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final entry = ref.watch(tasbihEntryProvider(entryId));
    if (entry == null) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations.tasbih_list_title)),
        body: Center(
          child: Text(localizations.tasbih_entry_not_found,
              textAlign: TextAlign.center),
        ),
      );
    }
    final session = ref.watch(
      tasbihSessionProvider(
        TasbihSessionArg(id: entry.id, target: entry.target),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(entry.dhikr)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: CircularCounter(
                    progress: session.progress,
                    count: session.count,
                    target: session.target,
                    semanticsLabel:
                        '${session.count} / ${session.target}',
                    onTap: () {
                      // E-2: light haptic only.
                      unawaited(HapticFeedback.lightImpact());
                      unawaited(
                        ref
                            .read(
                              tasbihSessionProvider(
                                TasbihSessionArg(
                                    id: entry.id, target: entry.target),
                              ).notifier,
                            )
                            .increment(),
                      );
                    },
                  ),
                ),
              ),
              if (session.isComplete)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: AppSpacing.m),
                  child: Text(localizations.tasbih_complete,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  // E-3: confirmation dialog + SnackBar on reset.
                  onPressed: () => _confirmReset(context, ref,
                      entry.id, entry.target, localizations),
                  child: Text(localizations.tasbih_reset),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmReset(
    BuildContext context,
    WidgetRef ref,
    String id,
    int target,
    AppLocalizations localizations,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(localizations.tasbih_reset_confirm_title),
        content: Text(localizations.tasbih_reset_confirm_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(localizations.tasbih_reset_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(localizations.tasbih_reset_confirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref
        .read(
          tasbihSessionProvider(
            TasbihSessionArg(id: id, target: target),
          ).notifier,
        )
        .reset();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.tasbih_reset_done)),
      );
    }
  }
}
