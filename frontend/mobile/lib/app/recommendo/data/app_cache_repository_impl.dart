import 'package:recommendo/app/recommendo/data/app_cache_repository_exception.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/service/repository/app_cache_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/local/google_auto_completion_local.dart';

class AppCacheRepositoryImpl implements AppCacheRepository {
  final RecommendationsLocal _localRecommendations;
  final GoogleAutoCompletionLocal _establishemnts;
  final GoogleAutoCompletionLocal _cities;

  const AppCacheRepositoryImpl(
    this._localRecommendations,
    this._establishemnts,
    this._cities,
  );

  @override
  Future<int> clearCache() async {
    try {
      final recommendationsCleared = await _localRecommendations.clearCache();
      final citiesCleared = await _cities.clearCache();
      final establishemntsCleared = await _establishemnts.clearCache();
      return recommendationsCleared + citiesCleared + establishemntsCleared;
    } on Exception {
      throw const AppCacheRepositoryException.failedClearCache();
    }
  }

  @override
  Future<int> getCacheSize() async {
    try {
      final recommendationsCleared = await _localRecommendations.cacheSize();
      final citiesCleared = await _cities.cacheSize();
      final establishemntsCleared = await _establishemnts.cacheSize();
      return recommendationsCleared + citiesCleared + establishemntsCleared;
    } on Exception {
      throw const AppCacheRepositoryException.failedGettingCacheSize();
    }
  }
}
