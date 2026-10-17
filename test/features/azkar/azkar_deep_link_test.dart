import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/app/deep_link_parser.dart';

void main() {
  group('DeepLinkParser azkar', () {
    test('resolves host+path links per category', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/morning')),
        '/azkar/morning',
      );
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/evening')),
        '/azkar/evening',
      );
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/sleep')),
        '/azkar/sleep',
      );
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/wake_up')),
        '/azkar/wake_up',
      );
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/tasbih')),
        '/tasbih',
      );
    });

    test('resolves the legacy test alias to the library', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://test/azkar')),
        '/azkar',
      );
    });

    test('returns null for unknown azkar paths', () {
      expect(
        DeepLinkParser.parse(Uri.parse('muslimguide://azkar/noon')),
        isNull,
      );
    });
  });
}
