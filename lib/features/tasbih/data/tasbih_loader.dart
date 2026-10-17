import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:muslim_guide/features/tasbih/domain/tasbih_pack.dart';

/// Loads the bundled tasbih pack and caches the result.
///
/// Returns null when the asset is absent or invalid; returns
/// [TasbihPack.pending] when the pack status is not APPROVED (Rule 020).
class TasbihLoader {
  /// Creates a loader for the supplied asset bundle.
  new({
    required this.assetBundle,
    this.assetPath = 'assets/content/tasbih/tasbih.json',
  });

  /// Bundled JSON path.
  final String assetPath;

  /// Asset bundle used to load the JSON file.
  final AssetBundle assetBundle;

  Future<TasbihPack?>? _pack;

  /// Returns the pack, or null when it is not shipped yet.
  Future<TasbihPack?> load() {
    return _pack ??= _load();
  }

  Future<TasbihPack?> _load() async {
    try {
      final raw = await assetBundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      return TasbihPack.fromJson(decoded);
    } on Object {
      return null;
    }
  }
}
