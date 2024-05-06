abstract class AppCacheRepository {
  Future<int> clearCache();

  Future<int> getCacheSize();
}
