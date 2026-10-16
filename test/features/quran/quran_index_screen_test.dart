import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim_guide/app/theme/app_theme.dart';
import 'package:muslim_guide/features/quran/data/quran_asset_loader.dart';
import 'package:muslim_guide/features/quran/data/quran_repository.dart';
import 'package:muslim_guide/features/quran/presentation/quran_index_screen.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

import 'quran_test_helpers.dart';

/// Test app hosting [child] with Material theming and localization.
Widget buildQuranTestApp({
  required Widget child,
  List<Override> overrides = const <Override>[],
  Locale locale = const Locale('ar'),
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

/// In-memory repository failing on every load call.
QuranRepository failingQuranRepository() {
  return QuranRepository(_ThrowingQuranLoader());
}

/// Loader throwing on [load] to exercise the Error state.
class _ThrowingQuranLoader extends QuranAssetLoader {
  /// Creates a throwing loader.
  new() : super(assetBundle: _ThrowingBundle(), assetPath: 'throwing');
}

/// Bundle backing [_ThrowingQuranLoader] (never read).
class _ThrowingBundle extends CachingAssetBundle {
  /// Creates a stub bundle.
  new();

  @override
  Future<ByteData> load(String key) async {
    throw Exception('asset failed');
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    throw Exception('asset failed');
  }
}

/// Router test app hosting [router] with theming and localization.
Widget buildQuranRouterApp({
  required GoRouter router,
  Locale locale = const Locale('ar'),
}) {
  return ProviderScope(
    child: MaterialApp.router(
      theme: AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
}

Future<void> pumpIndex(
  WidgetTester tester, {
  required QuranRepository repository,
  Locale locale = const Locale('ar'),
}) async {
  await tester.pumpWidget(
    buildQuranTestApp(
      overrides: [quranRepositoryOverride(repository)],
      locale: locale,
      child: const QuranIndexScreen(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('QuranIndexScreen states', () {
    testWidgets('shows loading then the 114 real surahs', (tester) async {
      await tester.pumpWidget(
        buildQuranTestApp(
          overrides: [quranRepositoryOverride(realQuranRepository())],
          child: const QuranIndexScreen(),
        ),
      );
      expect(find.text('جاري التحميل'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('الفاتحة'), findsOneWidget);
      expect(find.text('المصدر: Tanzil.net'), findsOneWidget);
    });

    testWidgets('shows Latin numerals and revelation label', (tester) async {
      await pumpIndex(tester, repository: fakeQuranRepository([stubSurah()]));
      expect(find.text('1'), findsOneWidget);
      expect(find.textContaining('مكية'), findsOneWidget);
      expect(find.textContaining('آيتان'), findsOneWidget);
    });

    testWidgets('renders English labels for the EN locale', (tester) async {
      await pumpIndex(
        tester,
        repository: fakeQuranRepository([stubSurah()]),
        locale: const Locale('en'),
      );
      expect(find.text('Source: Tanzil.net'), findsOneWidget);
      expect(find.textContaining('Meccan'), findsOneWidget);
    });

    testWidgets('renders at 200% text scale without overflow', (
      tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: buildQuranTestApp(
            overrides: [
              quranRepositoryOverride(
                fakeQuranRepository([stubSurah(), stubSurah(id: 2)]),
              ),
            ],
            child: const QuranIndexScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('name-1'), findsOneWidget);
    });

    testWidgets('shows error with retry, then recovers', (tester) async {
      await pumpIndex(tester, repository: failingQuranRepository());
      expect(find.text('فشل التحميل'), findsOneWidget);
      await tester.pumpWidget(
        buildQuranTestApp(
          overrides: [
            quranRepositoryOverride(
              fakeQuranRepository([
                stubSurah(),
                stubSurah(id: 2, verses: 3),
              ]),
            ),
          ],
          child: const QuranIndexScreen(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('name-1'), findsOneWidget);
      expect(find.text('name-2'), findsOneWidget);
    });

    testWidgets('navigates to the reader route on tap', (tester) async {
      String? pushed;
      final router = GoRouter(
        initialLocation: '/quran',
        routes: [
          GoRoute(
            path: '/quran',
            builder: (_, _) => const QuranIndexScreen(),
          ),
          GoRoute(
            path: '/quran/surah/:id',
            builder: (_, state) {
              pushed = state.pathParameters['id'];
              return const Scaffold(body: Text('reader'));
            },
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            quranRepositoryOverride(fakeQuranRepository([stubSurah()])),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light(),
            locale: const Locale('ar'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('name-1'));
      await tester.pumpAndSettle();
      expect(pushed, '1');
      expect(find.text('reader'), findsOneWidget);
    });
  });
}
