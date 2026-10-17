import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/app/deep_link_parser.dart';

void main() {
  group('DeepLinkParser.parse', () {
    test('resolves the prayer deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://prayer/now')),
        '/prayer',
      );
    });

    test('resolves the qibla deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://qibla/show')),
        '/qibla',
      );
    });

    test('resolves the location picker deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://location/pick')),
        '/location-picker',
      );
    });

    test('resolves the notification diagnostics deep link', () {
      expect(
        DeepLinkParser.parse(
          Uri.parse('muslimguide://diagnostics/notifications'),
        ),
        '/diagnostics/notifications',
      );
    });

    test('resolves the notifications settings deep link', () {
      expect(
        DeepLinkParser.parse(
          Uri.parse('muslimguide://notifications/settings'),
        ),
        '/settings/notifications',
      );
    });

    test('resolves the calculation settings deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://settings/calculation')),
        '/settings/calculation',
      );
    });

    test('resolves the hijri calendar deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://hijri/calendar')),
        '/hijri',
      );
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://test/hijri')),
        '/hijri',
      );
    });

    test('returns null for a bare path-only calculation route', () {
      expect(DeepLinkParser.parse(Uri.parse('/calculation')), isNull);
    });

    test('resolves the legacy prayer deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://test/prayer')),
        '/prayer',
      );
    });

    test('resolves the legacy qibla deep link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://test/qibla')),
        '/qibla',
      );
    });

    test('returns null for an unknown host', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://unknown/now')),
        isNull,
      );
    });

    test('returns null for an unknown path', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://prayer/later')),
        isNull,
      );
    });

    test('returns null for an unsupported scheme', () {
      expect(DeepLinkParser.parse(Uri.parse('https://prayer/now')), isNull);
    });

    test('resolves the path-only prayer link', () {
      expect(DeepLinkParser.parse(Uri.parse('/now')), '/prayer');
    });

    test('resolves the path-only qibla link', () {
      expect(DeepLinkParser.parse(Uri.parse('/show')), '/qibla');
    });

    test('resolves the path-only location picker link', () {
      expect(DeepLinkParser.parse(Uri.parse('/pick')), '/location-picker');
    });

    test('returns null for an unknown path-only link', () {
      expect(DeepLinkParser.parse(Uri.parse('/unknown')), isNull);
    });

    test('leaves the bare settings path unresolved', () {
      expect(DeepLinkParser.parse(Uri.parse('/settings')), isNull);
    });
  });
}
