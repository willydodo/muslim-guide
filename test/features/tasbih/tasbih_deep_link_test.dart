import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/app/deep_link_parser.dart';

void main() {
  group('DeepLinkParser tasbih (Phase 05c)', () {
    test('resolves the tasbih list link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://tasbih/list')),
        '/tasbih',
      );
    });

    test('resolves tasbih entry links by id', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://tasbih/subhanallah')),
        '/tasbih/subhanallah',
      );
      expect(
        DeepLinkParser.parse(
          Uri.parse('muslimguide://tasbih/subhanallah_wa_bihamdihi'),
        ),
        '/tasbih/subhanallah_wa_bihamdihi',
      );
    });

    test('reroutes the legacy azkar tasbih link', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/tasbih')),
        '/tasbih',
      );
    });

    test('resolves the test tasbih alias', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://test/tasbih')),
        '/tasbih',
      );
    });

    test('returns null for unknown tasbih paths', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://tasbih/INVALID-ID')),
        isNull,
      );
    });
  });
}
