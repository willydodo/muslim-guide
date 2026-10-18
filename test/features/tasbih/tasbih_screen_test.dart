import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_list_screen.dart';
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_screen.dart';

import 'tasbih_test_helpers.dart';

void main() {
  group('TasbihScreen', () {
    testWidgets('shows counter starting at zero', (tester) async {
      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(stubTasbihPack())],
          child: const TasbihScreen(entryId: 'subhanallah'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('DHIKR-subhanallah'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('shows not-found state for unknown id', (tester) async {
      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(stubTasbihPack())],
          child: const TasbihScreen(entryId: 'nope'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('DHIKR-subhanallah'), findsNothing);
    });

    testWidgets('reset button is present', (tester) async {
      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(stubTasbihPack())],
          child: const TasbihScreen(entryId: 'allahuakbar'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('DHIKR-allahuakbar'), findsOneWidget);
    });

    testWidgets('no overflow at 200% text scale (list + counter)',
        (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(
        tester.platformDispatcher.clearTextScaleFactorTestValue,
      );

      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(stubTasbihPack())],
          child: const TasbihListScreen(),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(stubTasbihPack())],
          child: const TasbihScreen(entryId: 'subhanallah'),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
