import 'package:json_annotation/json_annotation.dart';

part 'recommendation_payload_entity.g.dart';

@JsonSerializable(includeIfNull: false)
class RecommendationPayloadEntity {
  final String cityId;
  final String title;
  final String? description;
  final List<SourcePayload> source;

  const RecommendationPayloadEntity({
    required this.cityId,
    required this.title,
    required this.source,
    this.description,
  });

  factory RecommendationPayloadEntity.fromJson(Map<String, dynamic> json) =>
      _$RecommendationPayloadEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationPayloadEntityToJson(this);
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
