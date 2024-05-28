import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:recommendo/app/recommendo/service/repository/app_cache_repository.dart';

class AppImageCacheManager extends CacheManager
    with ImageCacheManager
    implements AppCacheRepository {
  static const key = 'appImageCacheManager';

  static final AppImageCacheManager _instance = AppImageCacheManager._();

  factory AppImageCacheManager() {
    return _instance;
  }

  AppImageCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 100,
          ),
        );

  @override
  Future<int> clearCache() async {
    await emptyCache();
    return Future.value(0);
  }

  @override
  Future<int> getCacheSize() {
    return Future.value(0);
  }
}
