import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/maps_api_status.dart';

part 'place_autocomplete_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceAutocompleteResponse {
  final List<PlaceAutocompletePrediction> predictions;
  final MapsApiStatus status;

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
