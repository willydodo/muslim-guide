import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/tasbih/application/tasbih_providers.dart';

import 'tasbih_test_helpers.dart';

void main() {
  group('tasbihSessionProvider', () {
    test('starts at zero then increments and resets', () async {
      final container = ProviderContainer(
        overrides: [
          tasbihPackOverride(stubTasbihPack()),
          tasbihRepositoryOverride(MemoryTasbihStorage()),
        ],
      );
      addTearDown(container.dispose);

      const arg = TasbihSessionArg(id: 'subhanallah', target: 33);
      final initial = container.read(tasbihSessionProvider(arg));
      expect(initial.count, 0);
      expect(initial.isComplete, isFalse);

      final notifier = container.read(
        tasbihSessionProvider(arg).notifier,
      );
      await notifier.increment();
      await notifier.increment();
      expect(container.read(tasbihSessionProvider(arg)).count, 2);

      await notifier.reset();
      expect(container.read(tasbihSessionProvider(arg)).count, 0);
    });

    test('caps at target', () async {
      final container = ProviderContainer(
        overrides: [
          tasbihPackOverride(stubTasbihPack()),
          tasbihRepositoryOverride(
            MemoryTasbihStorage({'tasbih_x_count': 99}),
          ),
        ],
      );
      addTearDown(container.dispose);

      const arg = TasbihSessionArg(id: 'x', target: 100);
      final notifier = container.read(
        tasbihSessionProvider(arg).notifier,
      );
      await notifier.increment();
      await notifier.increment();
      expect(container.read(tasbihSessionProvider(arg)).count, 100);
      expect(
        container.read(tasbihSessionProvider(arg)).isComplete,
        isTrue,
      );
    });
  });

  group('tasbihEntryProvider', () {
    test('resolves entries from the pack', () async {
      final container = ProviderContainer(
        overrides: [tasbihPackOverride(stubTasbihPack())],
      );
      addTearDown(container.dispose);

      await container.read(tasbihListProvider.future);
      expect(
        container.read(tasbihEntryProvider('allahuakbar'))?.target,
        34,
      );
      expect(container.read(tasbihEntryProvider('nope')), isNull);
    });
  });
}
