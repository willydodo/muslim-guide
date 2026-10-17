import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/hijri/data/hijri_calculator_impl.dart';
import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';

void main() {
  group('HijriCalculatorImpl', () {
    test('converts a known Gregorian date to a valid Hijri date', () {
      final calculator = HijriCalculatorImpl();
      final hijri = calculator.fromGregorian(DateTime(2024, 6, 15));
      expect(hijri.year, greaterThan(1400));
      expect(hijri.month, inInclusiveRange(1, 12));
      expect(hijri.day, inInclusiveRange(1, 30));
    });

    test('adjustment +1 shifts the Hijri date forward by one day', () {
      final base = HijriCalculatorImpl().fromGregorian(
        DateTime(2024, 6, 15),
      );
      final shifted = HijriCalculatorImpl(
        adjustment: 1,
      ).fromGregorian(DateTime(2024, 6, 15));
      final baseDate = HijriCalculatorImpl().toGregorian(base);
      final shiftedDate = HijriCalculatorImpl().toGregorian(shifted);
      expect(shiftedDate.difference(baseDate).inDays, 1);
    });

    test('adjustment -1 shifts the Hijri date backward by one day', () {
      final base = HijriCalculatorImpl().fromGregorian(
        DateTime(2024, 9, 15),
      );
      final shifted = HijriCalculatorImpl(
        adjustment: -1,
      ).fromGregorian(DateTime(2024, 9, 15));
      final baseDate = HijriCalculatorImpl().toGregorian(base);
      final shiftedDate = HijriCalculatorImpl().toGregorian(shifted);
      expect(shiftedDate.difference(baseDate).inDays, -1);
    });

    test('rejects adjustment outside -1..+1', () {
      expect(
        () => HijriCalculatorImpl(adjustment: 2),
        throwsArgumentError,
      );
      expect(
        () => HijriCalculatorImpl(adjustment: -2),
        throwsArgumentError,
      );
    });

    test('round-trips Gregorian -> Hijri -> Gregorian within one day', () {
      final calculator = HijriCalculatorImpl();
      final original = DateTime(2025, 6, 15);
      final hijri = calculator.fromGregorian(original);
      final back = calculator.toGregorian(hijri);
      expect(back.difference(original).inDays.abs(), lessThanOrEqualTo(1));
    });

    test('monthLength returns 29 or 30', () {
      final calculator = HijriCalculatorImpl();
      final hijri = calculator.fromGregorian(DateTime(2025, 3, 15));
      final length = calculator.monthLength(hijri.year, hijri.month);
      expect(length, anyOf([29, 30]));
    });

    test('HijriDate equality holds for identical values', () {
      const first = HijriDate(year: 1447, month: 9, day: 1);
      const second = HijriDate(year: 1447, month: 9, day: 1);
      expect(first, second);
      expect(first.hashCode, second.hashCode);
      expect(first.toString(), '1447/9/1');
    });
  });
}
