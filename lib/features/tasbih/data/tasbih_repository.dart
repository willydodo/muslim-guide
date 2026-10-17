import 'package:hive_ce/hive.dart';

/// Session state for one tasbih counter.
class TasbihSession {
  /// Creates a session state.
  const new({required this.count, required this.target});

  /// Current count.
  final int count;

  /// Target repetitions.
  final int target;

  /// True when the target is reached.
  bool get isComplete => count >= target;

  /// Progress 0.0–1.0.
  double get progress =>
      target <= 0 ? 0 : (count / target).clamp(0.0, 1.0);
}

/// Persists tasbih session counters (Phase 05c).
///
/// Keys: `tasbih_<id>_count` (int). Reset deletes the key (E-3: behind a
/// confirmation dialog + SnackBar in the UI layer).
class TasbihRepository {
  /// Creates a repository over [storage].
  new({required this.storage});

  /// Key-value storage (Hive settings box in production).
  final TasbihStorage storage;

  /// Count key for [id].
  static String countKey(String id) => 'tasbih_${id}_count';

  /// Reads the saved count for [id] (0 when absent).
  Future<int> readCount(String id) async {
    final value = storage.read(countKey(id));
    if (value is num && value.toInt() >= 0) {
      return value.toInt();
    }
    return 0;
  }

  /// Advances the count for [id] by one, capped at [target].
  Future<int> increment(String id, {required int target}) async {
    final next = (await readCount(id) + 1).clamp(0, target);
    await storage.write(countKey(id), next);
    return next;
  }

  /// Deletes the saved count for [id].
  Future<void> reset(String id) async {
    await storage.write(countKey(id), null);
  }
}

/// Key-value storage for tasbih counters.
abstract class TasbihStorage {
  /// Reads a stored value, or null when absent.
  Object? read(String key);

  /// Writes [value] for [key] (null deletes).
  Future<void> write(String key, Object? value);
}

/// In-memory storage for tests.
class MemoryTasbihStorage implements TasbihStorage {
  /// Creates in-memory storage.
  new([Map<String, Object?>? seed])
      : _map = Map<String, Object?>.from(seed ?? {});

  final Map<String, Object?> _map;

  @override
  Object? read(String key) => _map[key];

  @override
  Future<void> write(String key, Object? value) async {
    if (value == null) {
      _map.remove(key);
    } else {
      _map[key] = value;
    }
  }
}

/// Hive-backed storage using the shared settings box.
class HiveTasbihStorage implements TasbihStorage {
  /// Creates Hive storage (box may be null before bootstrap).
  new(this._box);

  final Box<dynamic>? _box;

  @override
  Object? read(String key) {
    final box = _box;
    if (box == null || !box.isOpen) return null;
    return box.get(key);
  }

  @override
  Future<void> write(String key, Object? value) async {
    final box = _box;
    if (box == null || !box.isOpen) {
      throw StateError('Hive tasbih storage is unavailable.');
    }
    if (value == null) {
      await box.delete(key);
    } else {
      await box.put(key, value);
    }
  }
}
