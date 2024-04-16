// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_payload_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationPayloadEntity _$RecommendationPayloadEntityFromJson(
        Map<String, dynamic> json) =>
    RecommendationPayloadEntity(
      city: CityResult.fromJson(json['city'] as Map<String, dynamic>),
      title: json['title'] as String,
      socialLink: json['socialLink'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecommendationPayloadEntityToJson(
        RecommendationPayloadEntity instance) =>
    <String, dynamic>{
      'city': instance.city,
      'title': instance.title,
      'description': instance.description,
      'socialLink': instance.socialLink,
    };
