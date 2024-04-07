// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_payload_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationPayloadEntity _$RecommendationPayloadEntityFromJson(
        Map<String, dynamic> json) =>
    RecommendationPayloadEntity(
      city: json['city'] as String,
      title: json['title'] as String,
      socialLinks: SocialLinksEntity.fromJson(
          json['socialLinks'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecommendationPayloadEntityToJson(
        RecommendationPayloadEntity instance) =>
    <String, dynamic>{
      'city': instance.city,
      'title': instance.title,
      'description': instance.description,
      'socialLinks': instance.socialLinks,
    };
