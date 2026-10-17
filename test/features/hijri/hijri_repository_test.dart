import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/hijri/data/hijri_events_data.dart';
import 'package:muslim_guide/features/hijri/data/repositories/hijri_repository_impl.dart';

import 'fakes/fake_hijri_calculator.dart';

void main() {
  group('HijriRepositoryImpl', () {
    test('getToday returns the fake anchor date', () async {
      final repository = HijriRepositoryImpl(
        calculator: FakeHijriCalculator(),
      );
      final today = await repository.fromGregorian(DateTime(2024, 6, 15));
      expect(today.year, 1445);
      expect(today.month, 12);
      expect(today.day, 9);
    });

    test('adjustment shifts the returned date', () async {
      final repository = HijriRepositoryImpl(
        calculator: FakeHijriCalculator(),
        adjustment: 1,
      );
      final shifted = await repository.fromGregorian(DateTime(2024, 6, 15));
      expect(shifted.day, 10);
    });

    test('getEventsForMonth returns only that month', () {
      final repository = HijriRepositoryImpl(
        calculator: FakeHijriCalculator(),
      );
      final ramadan = repository.getEventsForMonth(1447, 9);
      expect(ramadan, hasLength(1));
      expect(ramadan.first.nameKey, 'event_ramadan_start');
      final empty = repository.getEventsForMonth(1447, 2);
      expect(empty, isEmpty);
    });

    test('getUpcomingEvents respects the limit', () {
      final repository = HijriRepositoryImpl(
        calculator: FakeHijriCalculator(),
      );
      final events = repository.getUpcomingEvents(limit: 2);
      expect(events, hasLength(2));
    });

    test('kHijriEvents holds eight events with ARB keys', () {
      expect(kHijriEvents, hasLength(8));
      for (final event in kHijriEvents) {
        expect(event.month, inInclusiveRange(1, 12));
        expect(event.day, inInclusiveRange(1, 30));
        expect(event.nameKey, startsWith('event_'));
      }
    });

    test('rejects adjustment outside -1..+1', () {
      expect(
        () => HijriRepositoryImpl(
          calculator: FakeHijriCalculator(),
          adjustment: 2,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
