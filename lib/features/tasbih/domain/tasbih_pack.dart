import 'package:muslim_guide/features/tasbih/domain/tasbih_entry.dart';

/// Verified tasbih pack (Phase 05c, Rule 020).
///
/// Empty entries mean the pack has not been approved yet; the UI renders
/// the pending-pack Empty state.
class TasbihPack {
  /// Creates a pack.
  const new({required this.entries});

  /// Empty pack: no verified content approved yet (Rule 020).
  factory pending() {
    return const TasbihPack(entries: <TasbihEntry>[]);
  }

  /// Creates a pack from decoded JSON (review-schema shape).
  factory fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    if (status is String && status != 'APPROVED') {
      return TasbihPack.pending();
    }
    final rawItems = json['items'];
    if (rawItems is! List<dynamic>) {
      throw const FormatException('Tasbih pack field "items" must be a list.');
    }
    final entries = <TasbihEntry>[];
    final ids = <String>{};
    for (final raw in rawItems) {
      if (raw is! Map<String, dynamic>) {
        throw const FormatException('Each tasbih entry must be a JSON object.');
      }
      if (raw['grade_simple'] == 'review_required') {
        continue;
      }
      final entry = TasbihEntry.fromJson(raw);
      if (!ids.add(entry.id)) {
        throw FormatException('Duplicate tasbih entry id "${entry.id}".');
      }
      entries.add(entry);
    }
    return TasbihPack(entries: List<TasbihEntry>.unmodifiable(entries));
  }

  /// Entries in pack order.
  final List<TasbihEntry> entries;

  /// Entries for [section] ('after_prayer' or 'free').
  List<TasbihEntry> entriesFor(String section) {
    return entries.where((entry) => entry.section == section).toList();
  }

  /// Entry by [id], or null when absent.
  TasbihEntry? entryById(String id) {
    for (final entry in entries) {
      if (entry.id == id) return entry;
    }
    return null;
  }
}
