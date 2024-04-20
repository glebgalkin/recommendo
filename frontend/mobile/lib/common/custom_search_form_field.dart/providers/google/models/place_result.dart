import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

part 'place_result.g.dart';

@JsonSerializable()
class PlaceResult extends BaseSearchItem {
  const PlaceResult({
    required this.preview,
    required this.value,
  });

  @override
  final String preview;

  @override
  final String value;

  @override
  String? get previewImage => null;

  factory PlaceResult.fromJson(Map<String, dynamic> json) =>
      _$PlaceResultFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceResultToJson(this);
}
