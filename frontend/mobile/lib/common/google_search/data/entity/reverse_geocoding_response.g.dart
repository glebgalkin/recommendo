// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse_geocoding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverseGeoocodingResponse _$ReverseGeoocodingResponseFromJson(
        Map<String, dynamic> json) =>
    ReverseGeoocodingResponse(
      results: (json['results'] as List<dynamic>)
          .map(
              (e) => ReverseGeocodingResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$MapsApiStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ReverseGeoocodingResponseToJson(
        ReverseGeoocodingResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'status': _$MapsApiStatusEnumMap[instance.status]!,
    };

const _$MapsApiStatusEnumMap = {
  MapsApiStatus.ok: 'OK',
  MapsApiStatus.zeroResults: 'ZERO_RESULTS',
  MapsApiStatus.invalidRequest: 'INVALID_REQUEST',
  MapsApiStatus.overQueryLimit: 'OVER_QUERY_LIMIT',
  MapsApiStatus.requestDenied: 'REQUEST_DENIED',
  MapsApiStatus.unknownError: 'UNKNOWN_ERROR',
};

ReverseGeocodingResult _$ReverseGeocodingResultFromJson(
        Map<String, dynamic> json) =>
    ReverseGeocodingResult(
      formattedAddress: json['formatted_address'] as String,
      placeId: json['place_id'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ReverseGeocodingResultToJson(
        ReverseGeocodingResult instance) =>
    <String, dynamic>{
      'formatted_address': instance.formattedAddress,
      'place_id': instance.placeId,
      'types': instance.types,
    };
