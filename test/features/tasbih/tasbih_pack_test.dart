import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_entry.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_pack.dart';

void main() {
  Map<String, dynamic> validItem({
    String id = 'subhanallah',
    String section = 'after_prayer',
    int repeat = 33,
    String grade = 'صحيح',
  }) {
    return {
      'id': id,
      'arabic': 'حديث صحيح / Hadeeth text',
      'dhikr': 'ذكر قصير / short dhikr',
      'source_ref': 'HadeethEnc 6259',
      'degree_raw': 'صحيح',
      'grade': 'صحيح',
      'grade_simple': grade,
      'repeat': repeat,
      'section': section,
    };
  }

  Map<String, dynamic> validPack({
    String status = 'APPROVED',
    List<Map<String, dynamic>>? items,
  }) {
    return {
      'pack_id': 'tasbih-v1',
      'status': status,
      'items': items ??
          [
            validItem(),
            validItem(
              id: 'subhanallah_wa_bihamdihi',
              section: 'free',
              repeat: 100,
            ),
          ],
    };
  }

  group('TasbihEntry.fromJson', () {
    test('parses a valid entry', () {
      final entry = TasbihEntry.fromJson(validItem());
      expect(entry.id, 'subhanallah');
      expect(entry.target, 33);
      expect(entry.section, 'after_prayer');
      expect(entry.isApproved, isTrue);
    });

    test('review_required entry is not approved', () {
      final entry = TasbihEntry.fromJson(
        validItem(id: 'x', grade: 'review_required'),
      );
      expect(entry.isApproved, isFalse);
    });

    test('rejects unknown section', () {
      expect(
        () => TasbihEntry.fromJson(validItem(section: 'nope')),
        throwsFormatException,
      );
    });

    test('rejects non-positive repeat', () {
      expect(
        () => TasbihEntry.fromJson(validItem(repeat: 0)),
        throwsFormatException,
      );
    });
  });

  group('TasbihPack.fromJson', () {
    test('parses approved pack with sections', () {
      final pack = TasbihPack.fromJson(validPack());
      expect(pack.entries, hasLength(2));
      expect(pack.entriesFor('after_prayer'), hasLength(1));
      expect(pack.entriesFor('free'), hasLength(1));
      expect(pack.entryById('subhanallah')?.target, 33);
    });

    test('non-APPROVED status returns pending (empty)', () {
      final pack = TasbihPack.fromJson(validPack(status: 'PENDING_REVIEW'));
      expect(pack.entries, isEmpty);
    });

    test('filters review_required items', () {
      final pack = TasbihPack.fromJson(
        validPack(
          items: [
            validItem(),
            validItem(id: 'pending-one', grade: 'review_required'),
          ],
        ),
      );
      expect(pack.entries, hasLength(1));
      expect(pack.entryById('pending-one'), isNull);
    });

    test('rejects duplicate ids', () {
      expect(
        () => TasbihPack.fromJson(
          validPack(items: [validItem(), validItem()]),
        ),
        throwsFormatException,
      );
    });

    test('entryById returns null for unknown id', () {
      final pack = TasbihPack.fromJson(validPack());
      expect(pack.entryById('nope'), isNull);
    });
  });
}
