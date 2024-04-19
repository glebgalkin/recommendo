// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_autocomplete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceAutocompleteResponse _$PlaceAutocompleteResponseFromJson(
        Map<String, dynamic> json) =>
    PlaceAutocompleteResponse(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) =>
              PlaceAutocompletePrediction.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$AutoompleteStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$PlaceAutocompleteResponseToJson(
        PlaceAutocompleteResponse instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
      'status': _$AutoompleteStatusEnumMap[instance.status]!,
    };

const _$AutoompleteStatusEnumMap = {
  AutoompleteStatus.ok: 'OK',
  AutoompleteStatus.zeroResults: 'ZERO_RESULTS',
  AutoompleteStatus.invalidRequest: 'INVALID_REQUEST',
  AutoompleteStatus.overQueryLimit: 'OVER_QUERY_LIMIT',
  AutoompleteStatus.requestDenied: 'REQUEST_DENIED',
  AutoompleteStatus.unknownError: 'UNKNOWN_ERROR',
};

PlaceAutocompletePrediction _$PlaceAutocompletePredictionFromJson(
        Map<String, dynamic> json) =>
    PlaceAutocompletePrediction(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlaceAutocompletePredictionToJson(
        PlaceAutocompletePrediction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
      'types': instance.types,
    };
