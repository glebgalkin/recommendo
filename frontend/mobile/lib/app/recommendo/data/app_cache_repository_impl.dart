import 'package:recommendo/app/recommendo/data/app_cache_repository_exception.dart';
import 'package:recommendo/app/recommendo/service/repository/app_cache_repository.dart';

class AppCacheRepositoryImpl implements AppCacheRepository {
  final List<AppCacheRepository> _caches;

  const AppCacheRepositoryImpl(
    this._caches,
  );

  @override
  Future<int> clearCache() async {
    try {
      final futures = _caches.map((cache) => cache.clearCache());
      final clearedSizes = await Future.wait(futures);

      return clearedSizes.reduce((c1, c2) => c1 + c2);
    } on Exception {
      throw const AppCacheRepositoryException.failedClearCache();
    }
  }

  @override
  Future<int> getCacheSize() async {
    try {
      final futures = _caches.map((cache) => cache.getCacheSize());
      final sizes = await Future.wait(futures);

      return sizes.reduce((c1, c2) => c1 + c2);
    } on Exception {
      throw const AppCacheRepositoryException.failedGettingCacheSize();
    }
  }
}
