import 'package:muslim_guide/features/tasbih/data/tasbih_repository.dart';

/// Fake tasbih repository for widget tests.
///
/// In-memory counts, no Hive.
class FakeTasbihRepository implements TasbihRepository {
  /// Creates a fake with optional seeded counts.
  new({Map<String, int>? seedCounts})
      : _counts = Map<String, int>.from(seedCounts ?? {});

  final Map<String, int> _counts;

  @override
  TasbihStorage get storage => _FakeStorage(_counts);

  @override
  Future<int> readCount(String id) async => _counts[id] ?? 0;

  @override
  Future<int> increment(String id, {required int target}) async {
    final next = ((_counts[id] ?? 0) + 1).clamp(0, target);
    _counts[id] = next;
    return next;
  }

  @override
  Future<void> reset(String id) async {
    _counts.remove(id);
  }
}

/// Storage view over the fake's map.
class _FakeStorage implements TasbihStorage {
  /// Creates a storage view.
  new(this._counts);

  final Map<String, int> _counts;

  @override
  Object? read(String key) {
    final id = _idOf(key);
    return id == null ? null : _counts[id];
  }

  @override
  Future<void> write(String key, Object? value) async {
    final id = _idOf(key);
    if (id == null) return;
    if (value == null) {
      _counts.remove(id);
    } else if (value is num) {
      _counts[id] = value.toInt();
    }
  }

  String? _idOf(String key) {
    const prefix = 'tasbih_';
    const suffix = '_count';
    if (!key.startsWith(prefix) || !key.endsWith(suffix)) return null;
    return key.substring(prefix.length, key.length - suffix.length);
  }
}
