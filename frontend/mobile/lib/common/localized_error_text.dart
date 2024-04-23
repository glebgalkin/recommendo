import 'package:recommendo/l10n/l10n.dart';

String localizedErrorText(
  LocalizedErrorMessage? errorCode,
  AppLocalizations l10n,
) {
  return switch (errorCode) {
    // Auto Completion Error
    LocalizedErrorMessage.mapsApiAutocompleteInvalidRequest =>
      l10n.mapsApiAutocompleteInvalidRequest,
    // Google Maps Api fallbacks
    LocalizedErrorMessage.defaultMapsApiOverQueryLimit =>
      l10n.defaultMapsApiOverQueryLimit,
    LocalizedErrorMessage.deafultMapsApiError => l10n.deafultMapsApiError,
    // Geo Location Service errors
    LocalizedErrorMessage.geoLocationPermissionsNotGranted =>
      l10n.geoLocationPermissionsNotGranted,
    LocalizedErrorMessage.geoLocationNotFound => l10n.geoLocationNotFound,
    LocalizedErrorMessage.geoLocationPlatformError =>
      l10n.geoLocationPlatformError,
    LocalizedErrorMessage.geoLocationGoogleMapsApiError =>
      l10n.geoLocationGoogleMapsApiError,
    LocalizedErrorMessage.geoLocationNetworkError =>
      l10n.geoLocationNetworkError,
    // Recommendations Service error
    LocalizedErrorMessage.recommendationsInvalidTitle =>
      l10n.recommendationsInvalidTitle,
    LocalizedErrorMessage.recommendationsInvalidCity =>
      l10n.recommendationsInvalidCity,
    LocalizedErrorMessage.recommendationsInvalidSources =>
      l10n.recommendationsInvalidSources,
    LocalizedErrorMessage.recommendationsFailedDeletion =>
      l10n.recommendationsFailedDeletion,
    LocalizedErrorMessage.recommendationsNotFoundRecommendation =>
      l10n.recommendationsNotFoundRecommendation,
    LocalizedErrorMessage.recommendationsFailedSearch =>
      l10n.recommendationsFailedSearch,
    LocalizedErrorMessage.recommendationsServerNotAvailable =>
      l10n.recommendationsServerNotAvailable,
    LocalizedErrorMessage.recommendationsUnauthorized =>
      l10n.recommendationsUnauthorized,
    LocalizedErrorMessage.recommendationsUnknown => l10n.recommendationsUnknown,
    // fallbacks
    LocalizedErrorMessage.defaultNetworkError => l10n.defaultNetworErrorMessage,
    LocalizedErrorMessage.unknown => l10n.defaultErrorMessage,
    _ => l10n.defaultErrorMessage,
  };
}

enum LocalizedErrorMessage {
  // Auto Completion Error
  mapsApiAutocompleteInvalidRequest,
  // Google Maps Api fallbacks
  defaultMapsApiOverQueryLimit,
  deafultMapsApiError,
  // Geo Location Service errors
  geoLocationPermissionsNotGranted,
  geoLocationNotFound,
  geoLocationPlatformError,
  geoLocationGoogleMapsApiError,
  geoLocationNetworkError,
  // Recommendations repository error
  recommendationsInvalidTitle,
  recommendationsInvalidCity,
  recommendationsInvalidSources,
  recommendationsFailedDeletion,
  recommendationsNotFoundRecommendation,
  recommendationsFailedSearch,
  recommendationsServerNotAvailable,
  recommendationsUnauthorized,
  recommendationsUnknown,
  // fallbacks
  defaultNetworkError,
  unknown,
}
