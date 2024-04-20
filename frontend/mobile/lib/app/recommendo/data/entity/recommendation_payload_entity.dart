import 'package:json_annotation/json_annotation.dart';

part 'recommendation_payload_entity.g.dart';

@JsonSerializable(includeIfNull: false)
class RecommendationPayloadEntity {
  final CityPayload city;
  final String title;
  final String? description;
  final List<SourcePayload> sourcePayload;

  const RecommendationPayloadEntity({
    required this.city,
    required this.title,
    required this.sourcePayload,
    this.description,
  });

  factory RecommendationPayloadEntity.fromJson(Map<String, dynamic> json) =>
      _$RecommendationPayloadEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationPayloadEntityToJson(this);
}

@JsonSerializable()
class CityPayload {
  final String name;
  final String id;

  const CityPayload({
    required this.name,
    required this.id,
  });

  factory CityPayload.fromJson(Map<String, dynamic> json) =>
      _$CityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CityPayloadToJson(this);

  @override
  String toString() {
    return '''{ id: $id, name: $name }''';
  }
}

@JsonSerializable()
class SourcePayload {
  final String type;
  final String id;

  const SourcePayload({
    required this.type,
    required this.id,
  });

  factory SourcePayload.fromJson(Map<String, dynamic> json) =>
      _$SourcePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$SourcePayloadToJson(this);

  @override
  String toString() {
    return '''{ id: $id, type: $type }''';
  }
}
