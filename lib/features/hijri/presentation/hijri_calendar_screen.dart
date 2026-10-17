import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/features/hijri/application/hijri_providers.dart';
import 'package:muslim_guide/features/hijri/presentation/widgets/calendar_grid.dart';
import 'package:muslim_guide/features/hijri/presentation/widgets/calendar_parts.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Hijri calendar screen: month grid + adjustment.
///
/// States: loading / error + retry / success (UI_VISION §8).
/// Offline-first: all computation is local (DEC-0033).
class HijriCalendarScreen extends ConsumerWidget {
  /// Creates the calendar screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final todayAsync = ref.watch(hijriTodayProvider);
    final anchor = ref.watch(hijriMonthProvider);
    return Scaffold(
      appBar: AppBar(title: Text(loc.hijri_calendar_title)),
      body: SafeArea(
        child: todayAsync.when(
          loading: () => Center(child: Text(loc.hijri_loading)),
          error: (error, stackTrace) => CalendarError(
            message: loc.hijri_error,
            retryLabel: loc.hijri_retry,
            onRetry: () => ref.invalidate(hijriTodayProvider),
          ),
          data: (today) {
            final shownYear = today.year;
            final shownMonth = today.month;
            final monthName = _monthName(loc, shownMonth);
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                MonthNavigator(
                  label: loc.hijri_month_format(monthName, shownYear),
                ),
                const SizedBox(height: AppSpacing.m),
                CalendarGrid(
                  daysInMonth: 30,
                  firstWeekdayOffset: anchor.weekday % 7,
                  weekdayLabels: _weekdayLabels(context),
                  todayDay: today.day,
                ),
                const SizedBox(height: AppSpacing.l),
                const AdjustmentRow(),
              ],
            );
          },
        ),
      ),
    );
  }

  List<String> _weekdayLabels(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar') {
      return const ['سبت', 'أحد', 'اثن', 'ثلا', 'أرب', 'خمي', 'جمع'];
    }
    return const ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  }

  String _monthName(AppLocalizations loc, int month) {
    switch (month) {
      case 1:
        return loc.hijri_month_1;
      case 2:
        return loc.hijri_month_2;
      case 3:
        return loc.hijri_month_3;
      case 4:
        return loc.hijri_month_4;
      case 5:
        return loc.hijri_month_5;
      case 6:
        return loc.hijri_month_6;
      case 7:
        return loc.hijri_month_7;
      case 8:
        return loc.hijri_month_8;
      case 9:
        return loc.hijri_month_9;
      case 10:
        return loc.hijri_month_10;
      case 11:
        return loc.hijri_month_11;
      case 12:
      default:
        return loc.hijri_month_12;
    }
  }
}
