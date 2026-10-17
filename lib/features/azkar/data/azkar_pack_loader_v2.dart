import 'package:muslim_guide/features/azkar/domain/azkar_category.dart';
import 'package:muslim_guide/features/azkar/domain/azkar_pack.dart';

/// Converts core_v2 review-schema packs to AzkarPack.
///
/// core_v2 packs follow the content review workflow
/// (`pack_id`/`version`/`checksum`/`approval` + per-item review blocks).
/// The app domain model keeps its own shape, so this
/// converter bridges the two without touching the existing loader.
///
/// GAP-azkar-core-v2-converter: temporary bridge until the loader migrates
/// to the review schema. Review gating is the caller's responsibility —
/// this converter maps every item regardless of its review status.
/// Fields with no source data map as follows (never invented religious
/// text): `virtue` has no counterpart in the source file, so it carries
/// the [CoreV2PackConverter.noVirtueMarker] marker; `repeat_by_prayer`
/// and `repeat_note` have no domain field and are ignored (future UI work).
class CoreV2PackConverter {
  /// Creates a converter (stateless).
  const new();

  /// Marker used for the dhikr virtue placeholder when the source has no
  /// virtue text (the verified file carries text + source + grade only).
  static const String noVirtueMarker = '—';

  /// Converts one decoded core_v2 pack into an AzkarPack.
  ///
  /// [packJson] is the decoded `core_v2/<name>.json` map; [categoryId] is
  /// the owning category (core_v2 items carry no per-item category).
  AzkarPack convert({
    required Map<String, dynamic> packJson,
    required AzkarCategoryId categoryId,
  }) {
    final rawItems = packJson['items'];
    if (rawItems is! List<dynamic>) {
      throw const FormatException(
        'core_v2 pack field "items" must be a list.',
      );
    }
    final items = <Map<String, dynamic>>[];
    final ids = <String>{};
    for (final raw in rawItems) {
      if (raw is! Map<String, dynamic>) {
        throw const FormatException('Each core_v2 item must be an object.');
      }
      final id = raw['id'];
      if (id is! String || id.trim().isEmpty) {
        throw const FormatException('core_v2 item "id" must be non-empty.');
      }
      if (!ids.add(id)) {
        throw FormatException('Duplicate core_v2 item id "$id".');
      }
      final text = raw['arabic'];
      if (text is! String || text.trim().isEmpty) {
        throw FormatException('core_v2 item "$id" has empty "arabic".');
      }
      final repeat = raw['repeat'];
      if (repeat is! num || repeat.toInt() < 1) {
        throw FormatException('core_v2 item "$id" "repeat" must be >= 1.');
      }
      final sourceRef = raw['source_ref'];
      if (sourceRef is! String || sourceRef.trim().isEmpty) {
        throw FormatException('core_v2 item "$id" has empty "source_ref".');
      }
      items.add(<String, dynamic>{
        'id': id,
        'category': categoryId.value,
        'text': text,
        'virtue': noVirtueMarker,
        'repeat': repeat.toInt(),
        'source': sourceRef,
      });
    }
    return AzkarPack.fromJson(<String, dynamic>{
      'categories': [
        {'id': categoryId.value, 'total': items.length},
      ],
      'items': items,
    });
  }
}
