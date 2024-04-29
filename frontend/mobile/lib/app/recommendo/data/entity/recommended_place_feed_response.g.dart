// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_place_feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedPlaceFeedResponse _$RecommendedPlaceFeedResponseFromJson(
        Map<String, dynamic> json) =>
    RecommendedPlaceFeedResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      img: json['img'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => DataSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedCount: (json['recommendedCount'] as num).toInt(),
    );

Map<String, dynamic> _$RecommendedPlaceFeedResponseToJson(
        RecommendedPlaceFeedResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'img': instance.img,
      'sources': instance.sources,
      'recommendedCount': instance.recommendedCount,
    };

DataSource _$DataSourceFromJson(Map<String, dynamic> json) => DataSource(
      id: json['id'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
