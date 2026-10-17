/// Resolves supported external application URIs to internal route locations.
abstract final class DeepLinkParser {
  /// The application URI scheme.
  static const String scheme = 'muslimguide';

  /// Resolves a supported deep link, or returns null when it is unknown.
  static String? parse(Uri uri) {
    if (uri.scheme == scheme) {
      return _resolveHostPath(uri.host, uri.path);
    }
    if (uri.scheme.isNotEmpty) return null;

    return _resolvePathOnly(uri.path);
  }

  static String? _resolveHostPath(String host, String path) {
    return switch ((host, path)) {
      ('prayer', '/now') || ('test', '/prayer') => '/prayer',
      ('qibla', '/show') || ('test', '/qibla') => '/qibla',
      ('location', '/pick') => '/location-picker',
      ('diagnostics', '/notifications') => '/diagnostics/notifications',
      ('notifications', '/settings') => '/settings/notifications',
      ('settings', '/calculation') => '/settings/calculation',
      ('azkar', '/morning') => '/azkar/morning',
      ('azkar', '/evening') => '/azkar/evening',
      ('azkar', '/sleep') => '/azkar/sleep',
      ('azkar', '/wake_up') => '/azkar/wake_up',
      ('azkar', '/tasbih') => '/azkar/tasbih',
      ('test', '/azkar') => '/azkar',
      ('hijri', '/calendar') || ('test', '/hijri') => '/hijri',
      _ => null,
    };
  }

  static String? _resolvePathOnly(String path) {
    return switch (path) {
      '/now' => '/prayer',
      '/show' => '/qibla',
      '/pick' => '/location-picker',
      // '/settings' alone is intentionally unresolved: without the host
      // it is ambiguous, and GAP-deeplink-host-loss warns against
      // broadening path-only mappings.
      _ => null,
    };
  }
}
