import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/hijri/presentation/widgets/calendar_grid.dart';
import 'package:muslim_guide/features/hijri/presentation/widgets/event_card.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('CalendarGrid', () {
    testWidgets('renders 7 weekday headers plus day cells', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CalendarGrid(
            daysInMonth: 30,
            firstWeekdayOffset: 2,
            weekdayLabels: const ['س', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج'],
            todayDay: 1,
            eventDays: const {1, 15},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('س'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('highlights today and taps a day', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          CalendarGrid(
            daysInMonth: 29,
            firstWeekdayOffset: 0,
            weekdayLabels: const ['س', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج'],
            todayDay: 5,
            onDayTap: (_) => tapped = true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('5'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });
  });

  group('EventCard', () {
    testWidgets('shows name and days label', (tester) async {
      await tester.pumpWidget(
        _wrap(const EventCard(name: 'بداية رمضان', daysLabel: 'غداً')),
      );
      await tester.pumpAndSettle();
      expect(find.text('بداية رمضان'), findsOneWidget);
      expect(find.text('غداً'), findsOneWidget);
    });

    testWidgets('shows empty state label', (tester) async {
      await tester.pumpWidget(
        _wrap(const NoEventsView(label: 'لا مناسبات قادمة')),
      );
      await tester.pumpAndSettle();
      expect(find.text('لا مناسبات قادمة'), findsOneWidget);
    });
  });
}
