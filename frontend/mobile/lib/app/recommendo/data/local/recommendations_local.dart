import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';
import 'package:recommendo/app/recommendo/service/repository/app_cache_repository.dart';

class RecommendationsLocal implements AppCacheRepository {
  final Realm _realm;

  const RecommendationsLocal(this._realm);

  static const _kQuery =
      // ignore: lines_longer_than_80_chars
      r'cityId == $0 AND (title TEXT $1 OR description TEXT $1 SORT (recommendedCount DESC) LIMIT($2))';

  @override
  Future<int> getCacheSize() {
    if (kIsWeb) {
      return Future.value(-1);
    } else {
      return Future.value(_realm.all<RecommendationLocalModel>().length * 8);
    }
  }

  @override
  Future<int> clearCache() {
    final length = _realm.all<RecommendationLocalModel>().length;
    _realm.deleteAll<RecommendationLocalModel>();
    return Future.value(length);
  }

  Future<void> saveRecommendations(List<RecommendationLocalModel> list) async {
    return _realm.writeAsync(() {
      _realm.addAll(list);
    });
  }

  Future<List<RecommendationLocalModel>> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  }) async {
    return _realm
        .query<RecommendationLocalModel>(_kQuery, [cityId, '$term*', limit])
        .skip(offset)
        .toList();
  }
}
