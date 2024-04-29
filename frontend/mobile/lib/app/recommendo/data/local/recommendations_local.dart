import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';

class RecommendationsLocal {
  final Box<RecommendationLocalModel> _recommendationsBox;

  const RecommendationsLocal(this._recommendationsBox);

  Future<int> cacheSize() {
    final path = _recommendationsBox.path;
    if (kIsWeb) {
      return Future.value(-1);
    } else {
      return File(path!).length();
    }
  }

  Future<int> deleteAll() {
    return _recommendationsBox.clear();
  }

  Future<void> saveRecommendations(List<RecommendationLocalModel> list) {
    final map = {for (final entity in list) entity.id: entity};
    return _recommendationsBox.putAll(map);
  }

  Future<List<RecommendationLocalModel>> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  }) {
    if (_recommendationsBox.length < 1000) {
      return Future.value(
        _search(limit: limit, offset: offset, cityId: cityId, term: term),
      );
    }
    // TODO(Konyaka1): Not sure it is good idea to create isolate on each search
    // At the same time not sure creating worker might help here
    return compute(
      (_) => _search(limit: limit, offset: offset, cityId: cityId, term: term),
      null,
    );
  }

  List<RecommendationLocalModel> _search({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  }) {
    return _recommendationsBox.values
        .where((element) => element.cityId == cityId)
        .where(
          (element) =>
              term == null ||
              element.title.contains(term) ||
              element.description.contains(term),
        )
        .skip(offset)
        .take(limit)
        .toList();
  }
}
