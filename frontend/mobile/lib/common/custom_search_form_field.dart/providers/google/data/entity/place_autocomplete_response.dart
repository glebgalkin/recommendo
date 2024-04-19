import 'package:json_annotation/json_annotation.dart';

part 'place_autocomplete_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceAutocompleteResponse {
  final List<PlaceAutocompletePrediction> predictions;
  final AutoompleteStatus status;

  const PlaceAutocompleteResponse({
    required this.predictions,
    required this.status,
  });

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceAutocompleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceAutocompleteResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceAutocompletePrediction {
  final String description;
  final String placeId;
  final List<String> types;

  const PlaceAutocompletePrediction({
    required this.description,
    required this.placeId,
    required this.types,
  });

  factory PlaceAutocompletePrediction.fromJson(Map<String, dynamic> json) =>
      _$PlaceAutocompletePredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceAutocompletePredictionToJson(this);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum AutoompleteStatus {
  ok,
  zeroResults,
  invalidRequest,
  overQueryLimit,
  requestDenied,
  unknownError
}
