class AppCacheRepositoryException implements Exception {
  final AppCacheErrorCode code;

  const AppCacheRepositoryException._(this.code);

  const AppCacheRepositoryException.failedGettingCacheSize()
      : this._(AppCacheErrorCode.failedGettingCacheSize);

  const AppCacheRepositoryException.failedClearCache()
      : this._(AppCacheErrorCode.failedClearCache);

  const AppCacheRepositoryException.unknown()
      : this._(AppCacheErrorCode.unknown);
}

enum AppCacheErrorCode {
  // cache size
  failedGettingCacheSize,
  // clear cache
  failedClearCache,
  // common errors
  unknown,
}
