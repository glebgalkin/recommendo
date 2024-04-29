import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';

class RecommendationsLocal {
  final Isar _isar;

  const RecommendationsLocal(this._isar);

  Future<int> cacheSize() {
    if (kIsWeb) {
      return Future.value(-1);
    } else {
      return _isar.recommendationLocalModels.getSize();
    }
  }

  Future<int> deleteAll() async {
    final length = await _isar.recommendationLocalModels.count();
    await _isar.writeTxn(() => _isar.recommendationLocalModels.clear());
    return length;
  }

  Future<void> saveRecommendations(List<RecommendationLocalModel> list) {
    return _isar.writeTxn(() => _isar.recommendationLocalModels.putAll(list));
  }

  Future<List<RecommendationLocalModel>> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  }) async {
    final length = await _isar.recommendationLocalModels.count();
    if (length < 1000) {
      return _search(
        limit: limit,
        offset: offset,
        cityId: cityId,
        collection: _isar.recommendationLocalModels,
      );
    } else {
      return compute(
        _searchIsolate,
        _SearchCommand(
          limit: limit,
          offset: offset,
          cityId: cityId,
          directory: kIsWeb ? '' : _isar.directory!,
          term: term,
        ),
        debugLabel: '_searchIsolate',
      );
    }
  }

  static Future<List<RecommendationLocalModel>> _search({
    required int limit,
    required int offset,
    required String cityId,
    required IsarCollection<RecommendationLocalModel> collection,
    String? term,
  }) {
    if (term == null) {
      return collection
          .filter()
          .cityIdEqualTo(cityId)
          .sortByRecommendedCountDesc()
          .offset(offset)
          .limit(limit)
          .findAll();
    }
    return collection
        .filter()
        .cityIdEqualTo(cityId)
        .contentWordsElementContains(term, caseSensitive: false)
        .sortByRecommendedCountDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  static Future<List<RecommendationLocalModel>> _searchIsolate(
    _SearchCommand command,
  ) async {
    final isar = await Isar.open(
      [RecommendationLocalModelSchema],
      directory: command.directory,
      name: 'recommendationsModels',
    );

    return _search(
      limit: command.limit,
      offset: command.offset,
      cityId: command.cityId,
      term: command.term,
      collection: isar.recommendationLocalModels,
    );
  }
}

class _SearchCommand {
  final int limit;
  final int offset;
  final String cityId;
  final String directory;
  final String? term;

  const _SearchCommand({
    required this.limit,
    required this.offset,
    required this.cityId,
    required this.directory,
    required this.term,
  });
}
