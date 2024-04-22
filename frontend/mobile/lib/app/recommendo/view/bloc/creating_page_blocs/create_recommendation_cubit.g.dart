// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_recommendation_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRecommendationState _$CreateRecommendationStateFromJson(
        Map<String, dynamic> json) =>
    CreateRecommendationState(
      step: json['step'] as int,
      reverseAnimation: json['reverseAnimation'] as bool,
      city: json['city'] == null
          ? null
          : PlaceResult.fromJson(json['city'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$SocialLinkTypeEnumMap, json['type']),
      instagram: json['instagram'] as String,
      establishment: json['establishment'] == null
          ? null
          : PlaceResult.fromJson(json['establishment'] as Map<String, dynamic>),
      snackbarError: $enumDecodeNullable(
          _$LocalizedErrorMessageEnumMap, json['snackbarError']),
      sending: json['sending'] as bool? ?? false,
      close: json['close'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateRecommendationStateToJson(
        CreateRecommendationState instance) =>
    <String, dynamic>{
      'step': instance.step,
      'reverseAnimation': instance.reverseAnimation,
      'city': instance.city,
      'title': instance.title,
      'description': instance.description,
      'type': _$SocialLinkTypeEnumMap[instance.type]!,
      'instagram': instance.instagram,
      'establishment': instance.establishment,
    };

const _$SocialLinkTypeEnumMap = {
  SocialLinkType.instagram: 'instagram',
  SocialLinkType.googleMaps: 'googleMaps',
};

const _$LocalizedErrorMessageEnumMap = {
  LocalizedErrorMessage.mapsApiAutocompleteInvalidRequest:
      'mapsApiAutocompleteInvalidRequest',
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
  LocalizedErrorMessage.defaultNetworkError: 'defaultNetworkError',
  LocalizedErrorMessage.unknown: 'unknown',
};
