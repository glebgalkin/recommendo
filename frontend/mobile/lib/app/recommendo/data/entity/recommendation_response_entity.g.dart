// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationResponseEntity _$RecommendationResponseEntityFromJson(
        Map<String, dynamic> json) =>
    RecommendationResponseEntity(
      id: json['id'] as String,
      city: CityResponse.fromJson(json['city'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => DataSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecommendationResponseEntityToJson(
        RecommendationResponseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'title': instance.title,
      'description': instance.description,
      'sources': instance.sources,
    };

DataSource _$DataSourceFromJson(Map<String, dynamic> json) => DataSource(
      id: json['id'] as String,
      type: json['type'] as String,
      extra: json['extra'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'extra': instance.extra,
    };

CityResponse _$CityResponseFromJson(Map<String, dynamic> json) => CityResponse(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CityResponseToJson(CityResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
