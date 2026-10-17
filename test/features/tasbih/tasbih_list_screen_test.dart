import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_list_screen.dart';

import 'tasbih_test_helpers.dart';

void main() {
  group('TasbihListScreen', () {
    testWidgets('shows both section headers and entries', (tester) async {
      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(stubTasbihPack())],
          child: const TasbihListScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('DHIKR-subhanallah'), findsOneWidget);
      expect(find.text('DHIKR-allahuakbar'), findsOneWidget);
      expect(find.text('DHIKR-free-one'), findsOneWidget);
    });

    testWidgets('shows pending-pack Empty state when pack is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTasbihTestApp(
          overrides: [tasbihPackOverride(null)],
          child: const TasbihListScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('DHIKR-subhanallah'), findsNothing);
    });

    testWidgets('shows loading state before the first result', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTasbihTestApp(child: const TasbihListScreen()),
      );

      expect(find.text('DHIKR-subhanallah'), findsNothing);
    });
  });
}
