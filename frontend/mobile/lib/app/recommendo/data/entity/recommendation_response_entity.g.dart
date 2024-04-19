// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationResponseEntity _$RecommendationResponseEntityFromJson(
        Map<String, dynamic> json) =>
    RecommendationResponseEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      socialLink: json['socialLink'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$RecommendationResponseEntityToJson(
        RecommendationResponseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'socialLink': instance.socialLink,
      'city': instance.city,
      'address': instance.address,
    };
