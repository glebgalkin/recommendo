// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchState _$SearchStateFromJson(Map<String, dynamic> json) => SearchState(
      cityResult: json['cityResult'] == null
          ? null
          : PlaceResult.fromJson(json['cityResult'] as Map<String, dynamic>),
      term: json['term'] as String? ?? '',
      loadingGeoLocatoin: json['loadingGeoLocatoin'] as bool? ?? false,
      errorCode: $enumDecodeNullable(
          _$LocalizedErrorMessageEnumMap, json['errorCode']),
    );

Map<String, dynamic> _$SearchStateToJson(SearchState instance) =>
    <String, dynamic>{
      'cityResult': instance.cityResult,
    };

const _$LocalizedErrorMessageEnumMap = {
  LocalizedErrorMessage.mapsApiAutocompleteInvalidRequest:
      'mapsApiAutocompleteInvalidRequest',
  LocalizedErrorMessage.mapsApiAutocompleteLocalSearchError:
      'mapsApiAutocompleteLocalSearchError',
  LocalizedErrorMessage.defaultMapsApiOverQueryLimit:
      'defaultMapsApiOverQueryLimit',
  LocalizedErrorMessage.deafultMapsApiError: 'deafultMapsApiError',
  LocalizedErrorMessage.geoLocationPermissionsNotGranted:
      'geoLocationPermissionsNotGranted',
  LocalizedErrorMessage.geoLocationNotFound: 'geoLocationNotFound',
  LocalizedErrorMessage.geoLocationPlatformError: 'geoLocationPlatformError',
  LocalizedErrorMessage.geoLocationGoogleMapsApiError:
      'geoLocationGoogleMapsApiError',
  LocalizedErrorMessage.geoLocationNetworkError: 'geoLocationNetworkError',
  LocalizedErrorMessage.recommendationsInvalidTitle:
      'recommendationsInvalidTitle',
  LocalizedErrorMessage.recommendationsInvalidCity:
      'recommendationsInvalidCity',
  LocalizedErrorMessage.recommendationsInvalidSources:
      'recommendationsInvalidSources',
  LocalizedErrorMessage.recommendationsFailedDeletion:
      'recommendationsFailedDeletion',
  LocalizedErrorMessage.recommendationsNotFoundRecommendation:
      'recommendationsNotFoundRecommendation',
  LocalizedErrorMessage.recommendationsFailedSearch:
      'recommendationsFailedSearch',
  LocalizedErrorMessage.recommendationsFailedSearchLocal:
      'recommendationsFailedSearchLocal',
  LocalizedErrorMessage.recommendationsServerNotAvailable:
      'recommendationsServerNotAvailable',
  LocalizedErrorMessage.recommendationsUnauthorized:
      'recommendationsUnauthorized',
  LocalizedErrorMessage.recommendationsUnknown: 'recommendationsUnknown',
  LocalizedErrorMessage.defaultNetworkError: 'defaultNetworkError',
  LocalizedErrorMessage.unknown: 'unknown',
};
