import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/azkar/data/azkar_pack_loader_v2.dart';
import 'package:muslim_guide/features/azkar/domain/azkar_category.dart';

void main() {
  Map<String, dynamic> loadPack(String name) {
    final raw = File(
      'assets/content/azkar/core_v2/$name.json',
    ).readAsStringSync();
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  group('CoreV2PackConverter', () {
    test('converts morning pack (21 items)', () {
      final pack = const CoreV2PackConverter().convert(
        packJson: loadPack('morning'),
        categoryId: AzkarCategoryId.morning,
      );
      expect(pack.items, hasLength(21));
      expect(
        pack.itemsFor(AzkarCategoryId.morning),
        hasLength(21),
      );
      final first = pack.items.firstWhere((i) => i.id == 'morning_01');
      expect(first.textPlaceholder, contains('أَعُوذُ'));
      expect(first.repeatCount, 1);
      expect(first.sourcePlaceholder, contains('النسائي'));
      final mu = pack.items.firstWhere((i) => i.id == 'morning_02');
      expect(mu.repeatCount, 3);
    });

    test('converts evening pack (21 items)', () {
      final pack = const CoreV2PackConverter().convert(
        packJson: loadPack('evening'),
        categoryId: AzkarCategoryId.evening,
      );
      expect(pack.items, hasLength(21));
      expect(
        pack.itemsFor(AzkarCategoryId.evening),
        hasLength(21),
      );
    });

    test('rejects malformed input', () {
      const converter = CoreV2PackConverter();
      expect(
        () => converter.convert(
          packJson: <String, dynamic>{},
          categoryId: AzkarCategoryId.morning,
        ),
        throwsFormatException,
      );
      expect(
        () => converter.convert(
          packJson: <String, dynamic>{
            'items': [
              {'id': 'x'},
            ],
          },
          categoryId: AzkarCategoryId.morning,
        ),
        throwsFormatException,
      );
    });

    test('rejects duplicate ids', () {
      const converter = CoreV2PackConverter();
      Map<String, dynamic> item(String id) => <String, dynamic>{
            'id': id,
            'arabic': 'نص حقيقي',
            'repeat': 1,
            'source_ref': 'رواه مسلم (1)',
          };
      expect(
        () => converter.convert(
          packJson: <String, dynamic>{
            'items': [item('a'), item('a')],
          },
          categoryId: AzkarCategoryId.morning,
        ),
        throwsFormatException,
      );
    });
  });
}
