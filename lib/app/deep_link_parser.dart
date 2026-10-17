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
    // Phase 05c: tasbih entry deep links carry the entry id in the path.
    // 'list' is the list route itself, not an entry id.
    if (host == 'tasbih' && path.length > 1 && path != '/list') {
      final id = path.substring(1);
      if (RegExp(r'^[a-z_]+$').hasMatch(id)) {
        return '/tasbih/$id';
      }
    }
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
      ('azkar', '/tasbih') => '/tasbih',
      ('tasbih', '/list') => '/tasbih',
      ('test', '/azkar') => '/azkar',
      ('test', '/tasbih') => '/tasbih',
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
