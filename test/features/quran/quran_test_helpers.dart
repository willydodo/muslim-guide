import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muslim_guide/features/quran/application/quran_providers.dart';
import 'package:muslim_guide/features/quran/data/quran_asset_loader.dart';
import 'package:muslim_guide/features/quran/data/quran_repository.dart';
import 'package:muslim_guide/features/quran/domain/surah.dart';
import 'package:muslim_guide/features/quran/domain/verse.dart';

/// Reads the real bundled JSON from disk (tests run from the repo root, so
/// the asset is read directly instead of through the Flutter asset bundle).
String realQuranPayload() {
  return File('assets/content/quran/quran-uthmani.json').readAsStringSync();
}

/// Loader on the real bundled payload (tests only).
QuranAssetLoader realQuranLoader() {
  return QuranAssetLoader(assetBundle: _PayloadBundle(realQuranPayload()));
}

/// Repository backed by the real bundled asset on disk.
QuranRepository realQuranRepository() {
  return QuranRepository(realQuranLoader());
}

/// Repository serving an in-memory surah list.
QuranRepository fakeQuranRepository(List<Surah> surahs) {
  return QuranRepository(_FakeQuranLoader(surahs));
}

/// Builds a stub surah with [verses] sequential verses.
Surah stubSurah({int id = 1, int verses = 2}) {
  return Surah(
    id: id,
    nameAr: 'name-$id',
    nameEn: 'Name $id',
    verseCount: verses,
    revelation: RevelationType.meccan,
    order: id,
    verses: List<Verse>.generate(
      verses,
      (index) => Verse(surahId: id, number: index + 1, text: 'text-$index'),
    ),
  );
}

/// Repository override serving [repository].
Override quranRepositoryOverride(QuranRepository repository) {
  return quranRepositoryProvider.overrideWithValue(repository);
}

/// Test-only bundle serving a fixed [payload] for any requested key.
class _PayloadBundle extends CachingAssetBundle {
  /// Creates a bundle answering with [payload].
  /// Plain form required: `const new(...)` errors on the non-const super.
  // ignore: unnecessary_type_name_in_constructor // Plain form required: const new(...) errors on the non-const CachingAssetBundle super.
  _PayloadBundle(this.payload);

  /// JSON payload served for every load.
  final String payload;

  @override
  Future<ByteData> load(String key) async {
    return ByteData.sublistView(utf8.encode(payload));
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return payload;
  }
}

/// Loader serving an in-memory surah list.
class _FakeQuranLoader extends QuranAssetLoader {
  /// Creates a fake loader on [surahs].
  new(this.surahs)
      : super(assetBundle: _PayloadBundle('{}'), assetPath: 'fake');

  /// Surahs served by [load].
  final List<Surah> surahs;

  @override
  Future<List<Surah>> load() async => List<Surah>.unmodifiable(surahs);
}
