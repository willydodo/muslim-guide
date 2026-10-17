import 'package:flutter/material.dart';
import 'package:muslim_guide/app/theme/app_spacing.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';

/// Hijri month calendar grid (7 columns x up to 6 rows).
///
/// Pure layout: the caller supplies the number of [daysInMonth], the
/// weekday offset of day 1, and the seven [weekdayLabels]. All strings
/// are pre-localized by the caller — this widget holds no ARB keys.
class CalendarGrid extends StatelessWidget {
  /// Creates a calendar grid.
  const new({
    required this.daysInMonth,
    required this.firstWeekdayOffset,
    required this.weekdayLabels,
    this.todayDay,
    this.onDayTap,
    super.key,
  }) : assert(
         daysInMonth >= 29 && daysInMonth <= 30,
         'Hijri month must be 29 or 30 days.',
       ),
       assert(
         firstWeekdayOffset >= 0 && firstWeekdayOffset <= 6,
         'Weekday offset must be 0-6.',
       ),
       assert(
         weekdayLabels.length == 7,
         'Exactly seven weekday labels are required.',
       );

  /// Number of days in the displayed Hijri month (29 or 30).
  final int daysInMonth;

  /// Weekday offset of day 1 (0 = first column .. 6 = last column).
  final int firstWeekdayOffset;

  /// Seven weekday header labels (already localized, starting Saturday
  /// for ar / Sunday for en is handled by the caller).
  final List<String> weekdayLabels;

  /// Day number of today when the displayed month is current, else null.
  final int? todayDay;

  /// Called when a day cell is tapped.
  final ValueChanged<HijriDate?>? onDayTap;

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[];
    for (final label in weekdayLabels) {
      cells.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s),
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      );
    }
    for (var i = 0; i < firstWeekdayOffset; i++) {
      cells.add(const SizedBox.shrink());
    }
    for (var day = 1; day <= daysInMonth; day++) {
      cells.add(
        _DayCell(
          day: day,
          isToday: day == todayDay,
          onTap: onDayTap == null ? null : () => onDayTap!(null),
        ),
      );
    }
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cells,
    );
  }
}

/// Single day cell with today highlight.
class _DayCell extends StatelessWidget {
  /// Creates a day cell.
  const new({required this.day, required this.isToday, this.onTap});

  /// Day number.
  final int day;

  /// Whether this cell is today.
  final bool isToday;

  /// Tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      label: '$day',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.s),
        child: Container(
          alignment: Alignment.center,
          decoration: isToday
              ? BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppSpacing.s),
                )
              : null,
          child: Text(
            '$day',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: isToday ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }
}
