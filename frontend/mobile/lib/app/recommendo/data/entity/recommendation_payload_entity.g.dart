// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_payload_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationPayloadEntity _$RecommendationPayloadEntityFromJson(
        Map<String, dynamic> json) =>
    RecommendationPayloadEntity(
      cityId: json['cityId'] as String,
      title: json['title'] as String,
      sourcePayload: (json['sourcePayload'] as List<dynamic>)
          .map((e) => SourcePayload.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecommendationPayloadEntityToJson(
    RecommendationPayloadEntity instance) {
  final val = <String, dynamic>{
    'cityId': instance.cityId,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['sourcePayload'] = instance.sourcePayload;
  return val;
}

SourcePayload _$SourcePayloadFromJson(Map<String, dynamic> json) =>
    SourcePayload(
      type: json['type'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$SourcePayloadToJson(SourcePayload instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
    };
