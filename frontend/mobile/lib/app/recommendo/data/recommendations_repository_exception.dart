class RecommendationsRepositoryError implements Exception {
  final RecommendationsErrorCode code;

  const RecommendationsRepositoryError._(this.code);

  const RecommendationsRepositoryError.invalidTitle()
      : this._(RecommendationsErrorCode.invalidTitle);

  const RecommendationsRepositoryError.invalidCity()
      : this._(RecommendationsErrorCode.invalidCity);

  const RecommendationsRepositoryError.invalidSources()
      : this._(RecommendationsErrorCode.invalidSources);

  const RecommendationsRepositoryError.failedDeletion()
      : this._(RecommendationsErrorCode.failedDeletion);

  const RecommendationsRepositoryError.notFoundRecommendation()
      : this._(RecommendationsErrorCode.notFoundRecommendation);

  const RecommendationsRepositoryError.failedSearch()
      : this._(RecommendationsErrorCode.failedSearch);

  const RecommendationsRepositoryError.failedSearchLocal()
      : this._(RecommendationsErrorCode.failedSearchLocal);

  const RecommendationsRepositoryError.serverNotAvailable()
      : this._(RecommendationsErrorCode.serverNotAvailable);

  const RecommendationsRepositoryError.unauthorized()
      : this._(RecommendationsErrorCode.unauthorized);

  const RecommendationsRepositoryError.unknown()
      : this._(RecommendationsErrorCode.unknown);
}

enum RecommendationsErrorCode {
  // create endpoint
  invalidTitle,
  invalidCity,
  invalidSources,
  // delete endpoint
  failedDeletion,
  // get endpoint
  notFoundRecommendation,
  // search
  failedSearch,
  failedSearchLocal,
  // common errors
  serverNotAvailable,
  unauthorized,
  unknown,
}
