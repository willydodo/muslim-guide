import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/app/providers/bootstrap_provider.dart';
import 'package:muslim_guide/features/hijri/data/hijri_calculator_impl.dart';
import 'package:muslim_guide/features/hijri/data/repositories/hijri_repository_impl.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';
import 'package:muslim_guide/features/hijri/domain/repositories/hijri_repository.dart';

/// Holds the Hijri date adjustment in days (-1, 0, +1); defaults to 0
/// (REQ-HIJRI-001, DEC-0033).
final hijriAdjustmentProvider =
    NotifierProvider<HijriAdjustmentNotifier, int>(HijriAdjustmentNotifier.new);

/// Updates and persists the Hijri date adjustment.
class HijriAdjustmentNotifier extends Notifier<int> {
  bool _touched = false;
  bool _disposed = false;

  @override
  int build() {
    // Re-hydrate once bootstrap makes storage available.
    ref.watch(hiveStoreProvider);
    _disposed = false;
    ref.onDispose(() => _disposed = true);
    unawaited(_restore());
    return 0;
  }

  /// Selects [adjustment] (-1, 0, +1) and persists it.
  Future<void> setAdjustment(int adjustment) async {
    if (adjustment < -1 || adjustment > 1) {
      throw ArgumentError.value(
        adjustment,
        'adjustment',
        'Expected -1, 0, or +1.',
      );
    }
    _touched = true;
    state = adjustment;
    await ref.read(settingsRepositoryProvider).setHijriAdjustment(adjustment);
  }

  Future<void> _restore() async {
    if (ref.read(hiveStoreProvider) == null) {
      return;
    }
    try {
      final saved =
          await ref.read(settingsRepositoryProvider).getHijriAdjustment();
      if (_touched || _disposed) return;
      state = saved;
    } on Object catch (error, stack) {
      developer.log(
        'Failed to restore the saved Hijri adjustment.',
        name: 'muslim_guide.hijri',
        error: error,
        stackTrace: stack,
      );
    }
  }
}

/// Provides the Hijri repository over the current adjustment.
final hijriRepositoryProvider = Provider<HijriRepository>((ref) {
  final adjustment = ref.watch(hijriAdjustmentProvider);
  return HijriRepositoryImpl(
    calculator: HijriCalculatorImpl(),
    adjustment: adjustment,
  );
});

/// Today's Hijri date with the user adjustment applied.
///
/// autoDispose: recomputed when the calendar screen is opened.
final AutoDisposeFutureProvider<HijriDate> hijriTodayProvider =
    FutureProvider.autoDispose<HijriDate>(
  (ref) => ref.watch(hijriRepositoryProvider).getToday(),
);

/// Currently displayed Gregorian month anchor for the calendar grid.
///
/// autoDispose: released when the calendar screen is popped.
final AutoDisposeStateProvider<DateTime> hijriMonthProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
