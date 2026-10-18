import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:muslim_guide/features/tasbih/data/tasbih_loader.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_pack.dart';

void main() {
  Map<String, dynamic> withDhikr(
      Map<String, dynamic> base, String label) {
    return {...base, 'dhikr': label};
  }

  Map<String, dynamic> item(String id, String section, int repeat) {
    return {
      'id': id,
      'arabic': 'حديث صحيح',
      'source_ref': 'HadeethEnc test',
      'degree_raw': 'صحيح',
      'grade': 'صحيح',
      'grade_simple': 'صحيح',
      'repeat': repeat,
      'section': section,
    };
  }

  Map<String, dynamic> approvedPackJson() {
    return {
      'pack_id': 'tasbih-v1',
      'status': 'APPROVED',
      'items': [
        withDhikr(item('subhanallah', 'after_prayer', 33), 'ذكر'),
      ],
    };
  }

  /// Real-pack-shaped APPROVED fixture: three free-section items carry no
  /// 'dhikr' short label (as in the bundled tasbih.json). The model must
  /// fall back to the APPROVED spec-table labels instead of failing.
  Map<String, dynamic> approvedPackJsonNoDhikr() {
    return {
      'pack_id': 'tasbih-v1',
      'status': 'APPROVED',
      'items': [
        withDhikr(item('subhanallah', 'after_prayer', 33), 'ذكر'),
        item('subhanallah_wa_bihamdihi', 'free', 100),
        item('la_ilaha_illallah', 'free', 100),
        item('astaghfirullah', 'free', 100),
      ],
    };
  }

  group('TasbihLoader', () {
    test('returns null when the asset is absent', () async {
      final loader = TasbihLoader(
        assetBundle: _MissingBundle(),
      );
      expect(await loader.load(), isNull);
    });

    test('returns pending pack when status is not APPROVED', () async {
      final loader = TasbihLoader(
        assetBundle: _FixedBundle({
          'pack_id': 'tasbih-v1',
          'status': 'PENDING_REVIEW',
          'items': <dynamic>[],
        }),
      );
      final pack = await loader.load();
      expect(pack, isA<TasbihPack>());
      expect(pack?.entries, isEmpty);
    });

    test('loads an approved pack', () async {
      final loader = TasbihLoader(
        assetBundle: _FixedBundle(approvedPackJson()),
      );
      final pack = await loader.load();
      expect(pack?.entries, hasLength(1));
      expect(pack?.entries.first.id, 'subhanallah');
    });

    test('loads items missing the dhikr label via spec fallback', () async {
      final loader = TasbihLoader(
        assetBundle: _FixedBundle(approvedPackJsonNoDhikr()),
      );
      final pack = await loader.load();
      expect(pack?.entries, hasLength(4));
      expect(pack?.entries.map((entry) => entry.id), containsAll([
        'subhanallah',
        'subhanallah_wa_bihamdihi',
        'la_ilaha_illallah',
        'astaghfirullah',
      ]));
      for (final entry in pack!.entries) {
        expect(entry.dhikr.trim(), isNotEmpty);
      }
    });

    test('returns null on invalid JSON shape', () async {
      final loader = TasbihLoader(
        assetBundle: _FixedBundle(['not', 'a', 'map']),
      );
      expect(await loader.load(), isNull);
    });
  });
}

/// Asset bundle that throws on every load (missing asset).
class _MissingBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) {
    throw FlutterError('asset missing: $key');
  }

  @override
  Future<ByteData> load(String key) {
    throw FlutterError('asset missing: $key');
  }
}

/// Asset bundle serving one fixed JSON document.
class _FixedBundle extends CachingAssetBundle {
  new(this.document);

  final Object document;

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return _encode(document);
  }

  @override
  Future<ByteData> load(String key) async {
    final encoded = _encode(document);
    final bytes = Uint8List.fromList(encoded.codeUnits);
    return ByteData.view(bytes.buffer);
  }

  String _encode(Object value) {
    if (value is String) return '"$value"';
    if (value is List<dynamic>) {
      final parts = value.map(
        (element) => _encode(element as Object),
      );
      return '[${parts.join(',')}]';
    }
    if (value is Map<String, dynamic>) {
      final pairs = value.entries.map(
        (entry) => '"${entry.key}":${_encode(entry.value as Object)}',
      );
      return '{${pairs.join(',')}}';
    }
    if (value is num || value is bool) return '$value';
    throw FlutterError('unsupported test value: $value');
  }
}
