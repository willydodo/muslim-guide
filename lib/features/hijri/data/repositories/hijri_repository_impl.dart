import 'package:muslim_guide/features/hijri/domain/models/hijri_date.dart';
import 'package:muslim_guide/features/hijri/domain/repositories/hijri_repository.dart';
import 'package:muslim_guide/features/hijri/domain/services/hijri_calculator.dart';

/// Repository implementation over [HijriCalculator] (DEC-0033).
class HijriRepositoryImpl implements HijriRepository {
  /// Creates a repository.
  new({
    required this._calculator,
    this._adjustment = 0,
  }) : assert(
         _adjustment >= -1 && _adjustment <= 1,
         'adjustment must be -1, 0, or +1 (REQ-HIJRI-001).',
       );

  final HijriCalculator _calculator;
  final int _adjustment;

  @override
  Future<HijriDate> getToday() {
    return fromGregorian(DateTime.now());
  }

  @override
  Future<HijriDate> fromGregorian(DateTime date) async {
    final adjusted = date.add(Duration(days: _adjustment));
    return _calculator.fromGregorian(adjusted);
  }
}
