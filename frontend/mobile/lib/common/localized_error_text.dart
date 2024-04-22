import 'package:recommendo/l10n/l10n.dart';

String localizedErrorText(
  LocalizedErrorMessage? errorCode,
  AppLocalizations l10n,
) {
  return switch (errorCode) {
    // Auto Completion Error
    LocalizedErrorMessage.mapsApiAutocompleteInvalidRequest =>
      l10n.autoCompleteErrorInvalidRequest,
    // Google Maps Api fallbacks
    LocalizedErrorMessage.defaultMapsApiOverQueryLimit =>
      l10n.autoCompleteErrorOverQueryLimit,
    LocalizedErrorMessage.deafultMapsApiError => l10n.defaultNetworErrorMessage,
    // Geo Location Service errors
    LocalizedErrorMessage.geoLocationPermissionsNotGranted =>
      l10n.defaultNetworErrorMessage,
    LocalizedErrorMessage.geoLocationNotFound => l10n.defaultNetworErrorMessage,
    LocalizedErrorMessage.geoLocationPlatformError =>
      l10n.defaultNetworErrorMessage,
    LocalizedErrorMessage.geoLocationGoogleMapsApiError =>
      l10n.defaultNetworErrorMessage,
    LocalizedErrorMessage.geoLocationNetworkError =>
      l10n.defaultNetworErrorMessage,
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
  // fallbacks
  defaultNetworkError,
  unknown,
}
