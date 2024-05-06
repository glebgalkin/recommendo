import 'package:recommendo/app/recommendo/data/app_cache_repository_exception.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/service/repository/app_cache_repository.dart';
import 'package:recommendo/common/app_image_cache_manager.dart';
import 'package:recommendo/common/google_search/data/local/google_auto_completion_local.dart';

class AppCacheRepositoryImpl implements AppCacheRepository {
  final RecommendationsLocal _localRecommendations;
  final GoogleAutoCompletionLocal _establishemnts;
  final GoogleAutoCompletionLocal _cities;
  // for now ignored in cache size
  final AppImageCacheManager _images;

  const AppCacheRepositoryImpl(
    this._localRecommendations,
    this._establishemnts,
    this._cities,
    this._images,
  );

  @override
  Future<int> clearCache() async {
    try {
      final recommendationsCleared = await _localRecommendations.clearCache();
      final citiesCleared = await _cities.clearCache();
      final establishemntsCleared = await _establishemnts.clearCache();
      await _images.emptyCache();
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
