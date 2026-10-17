import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim_guide/app/deep_link_parser.dart';
import 'package:muslim_guide/app/providers/bootstrap_provider.dart';
import 'package:muslim_guide/core/logging/local_error_log.dart';
import 'package:muslim_guide/features/azkar/domain/azkar_category.dart';
import 'package:muslim_guide/features/azkar/presentation/azkar_detail_screen.dart';
import 'package:muslim_guide/features/azkar/presentation/azkar_library_screen.dart';
import 'package:muslim_guide/features/hijri/presentation/hijri_calendar_screen.dart';
import 'package:muslim_guide/features/home/presentation/home_placeholder.dart';
import 'package:muslim_guide/features/notifications/presentation/notification_diagnostics_screen.dart';
import 'package:muslim_guide/features/onboarding/presentation/language_selection_screen.dart';
import 'package:muslim_guide/features/prayer/presentation/screens/location_picker_screen.dart';
import 'package:muslim_guide/features/prayer/presentation/screens/prayer_times_screen.dart';
import 'package:muslim_guide/features/qibla/presentation/qibla_screen.dart';
import 'package:muslim_guide/features/quran/presentation/quran_index_screen.dart';
import 'package:muslim_guide/features/quran/presentation/surah_reader_screen.dart';
import 'package:muslim_guide/features/settings/presentation/screens/calculation_settings_screen.dart';
import 'package:muslim_guide/features/settings/presentation/screens/notifications_settings_screen.dart';
import 'package:muslim_guide/features/splash/presentation/splash_screen.dart';
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_list_screen.dart';
import 'package:muslim_guide/features/tasbih/presentation/screens/tasbih_screen.dart';

/// Provides the application router.
final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final deepLinkLocation = await redirectDeepLink(
        state.uri,
        logUnknownUri: (uri) => LocalErrorLog.instance.log(
          level: 'warning',
          message: 'Unknown deep link: $uri',
        ),
      );
      if (deepLinkLocation != null) return deepLinkLocation;

      if (state.matchedLocation == '/splash' ||
          state.matchedLocation == '/onboarding/language') {
        return null;
      }

      if (state.matchedLocation == '/home') {
        final settings = ref.read(settingsRepositoryProvider);
        if (!await settings.isOnboardingCompleted()) {
          return '/onboarding/language';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding/language',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/home',
        // TODO(phase-01-followup): insert /onboarding/welcome between /language and /home.
        builder: (context, state) => const HomePlaceholder(),
      ),
      GoRoute(
        path: '/prayer',
        builder: (context, state) => const PrayerTimesScreen(),
      ),
      GoRoute(
        path: '/location-picker',
        builder: (context, state) => const LocationPickerScreen(),
      ),
      GoRoute(path: '/qibla', builder: (context, state) => const QiblaScreen()),
      // Phase 08: Hijri calendar (DEC-0033).
      GoRoute(
        path: '/hijri',
        builder: (context, state) => const HijriCalendarScreen(),
      ),
      // Phase 06 Task 2: Quran index + Mushaf reader (Step 5).
      GoRoute(
        path: '/quran',
        builder: (context, state) => const QuranIndexScreen(),
        routes: [
          GoRoute(
            path: 'surah/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null || id < 1 || id > 114) {
                return const QuranIndexScreen();
              }
              return SurahReaderScreen(surahId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/diagnostics/notifications',
        builder: (context, state) => const NotificationDiagnosticsScreen(),
      ),
      GoRoute(
        path: '/settings/notifications',
        builder: (context, state) => const NotificationsSettingsScreen(),
      ),
      GoRoute(
        path: '/settings/calculation',
        builder: (context, state) => const CalculationSettingsScreen(),
      ),
      GoRoute(
        path: '/tasbih',
        builder: (context, state) => const TasbihListScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return TasbihScreen(entryId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/azkar',
        builder: (context, state) => const AzkarLibraryScreen(),
        routes: [
          GoRoute(
            path: ':category',
            builder: (context, state) {
              final raw = state.pathParameters['category'];
              final category = AzkarCategoryId.fromValue(raw) ??
                  AzkarCategoryId.morning;
              return AzkarDetailScreen(categoryId: category);
            },
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Redirects a deep link to its internal route, or falls back for unknown URIs.
Future<String?> redirectDeepLink(
  Uri uri, {
  required Future<void> Function(String uri) logUnknownUri,
}) async {
  final location = DeepLinkParser.parse(uri);
  if (location != null) return location;
  if (uri.scheme.toLowerCase() != DeepLinkParser.scheme) return null;

  final safeUri = Uri(
    scheme: uri.scheme,
    host: uri.host,
    path: uri.path,
  ).toString();
  try {
    await logUnknownUri(safeUri);
  } on Object catch (error, stackTrace) {
    developer.log(
      'Failed to record an unknown deep link.',
      name: 'muslim_guide.router',
      error: error,
      stackTrace: stackTrace,
    );
  }
  return '/prayer';
}
