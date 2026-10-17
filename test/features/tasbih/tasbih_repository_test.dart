import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/tasbih/data/tasbih_repository.dart';

void main() {
  group('TasbihRepository with memory storage', () {
    test('readCount returns 0 when absent', () async {
      final repo = TasbihRepository(
        storage: MemoryTasbihStorage(),
      );
      expect(await repo.readCount('subhanallah'), 0);
    });

    test('increment advances and persists', () async {
      final repo = TasbihRepository(
        storage: MemoryTasbihStorage(),
      );
      expect(await repo.increment('subhanallah', target: 33), 1);
      expect(await repo.increment('subhanallah', target: 33), 2);
      expect(await repo.readCount('subhanallah'), 2);
    });

    test('increment caps at target', () async {
      final repo = TasbihRepository(
        storage: MemoryTasbihStorage({'tasbih_x_count': 99}),
      );
      expect(await repo.increment('x', target: 100), 100);
      expect(await repo.increment('x', target: 100), 100);
    });

    test('reset deletes the count', () async {
      final repo = TasbihRepository(
        storage: MemoryTasbihStorage({'tasbih_x_count': 5}),
      );
      await repo.reset('x');
      expect(await repo.readCount('x'), 0);
    });

    test('countKey format', () {
      expect(TasbihRepository.countKey('subhanallah'),
          'tasbih_subhanallah_count');
    });
  });

  group('TasbihSession', () {
    test('progress and completion', () {
      const half = TasbihSession(count: 50, target: 100);
      expect(half.progress, 0.5);
      expect(half.isComplete, isFalse);

      const done = TasbihSession(count: 100, target: 100);
      expect(done.progress, 1.0);
      expect(done.isComplete, isTrue);
    });
  });
}
