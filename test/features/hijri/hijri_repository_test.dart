import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/hijri/data/repositories/hijri_repository_impl.dart';

import 'fakes/fake_hijri_calculator.dart';

void main() {
  group('HijriRepositoryImpl', () {
    test('getToday returns the fake anchor date', () async {
      final repository = HijriRepositoryImpl(calculator: FakeHijriCalculator());
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
