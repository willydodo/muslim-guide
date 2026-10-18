import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:muslim_guide/app/router.dart' show redirectDeepLink;
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_list_screen.dart';
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_screen.dart';

/// Task 3-9: tasbih navigation on a real device.
///
/// Opens `/tasbih` through a real GoRouter, verifies the list renders,
/// and navigates to one counter screen.
///
/// Device evidence (manual): `adb shell am start -d
/// "muslimguide://tasbih/subhanallah"` opens the counter screen.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  GoRouter buildRouter(String initialLocation) {
    final router = GoRouter(
      initialLocation: initialLocation,
      redirect: (_, state) =>
          redirectDeepLink(state.uri, logUnknownUri: (_) async {}),
      routes: [
        GoRoute(
          path: '/tasbih',
          builder: (_, _) => const TasbihListScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, state) => TasbihScreen(
                entryId: state.pathParameters['id'] ?? '',
              ),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    return router;
  }

  testWidgets('opens the tasbih list', (tester) async {
    final router = buildRouter('/tasbih');
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(TasbihListScreen), findsOneWidget);
  });

  testWidgets('opens a tasbih counter by id', (tester) async {
    final router = buildRouter('/tasbih/subhanallah');
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(TasbihScreen), findsOneWidget);
  });
}
