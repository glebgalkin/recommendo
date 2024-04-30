import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/common/google_search/data/entity/maps_api_status.dart';

part 'reverse_geocoding_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReverseGeoocodingResponse {
  final List<ReverseGeocodingResult> results;
  final MapsApiStatus status;

  const ReverseGeoocodingResponse({
    required this.results,
    required this.status,
  });

  factory ReverseGeoocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeoocodingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeoocodingResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReverseGeocodingResult {
  final String formattedAddress;
  final String placeId;
  final List<String> types;

  const ReverseGeocodingResult({
    required this.formattedAddress,
    required this.placeId,
    required this.types,
  });

  factory ReverseGeocodingResult.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeocodingResultFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodingResultToJson(this);
}
