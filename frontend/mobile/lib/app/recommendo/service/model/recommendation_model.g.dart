// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      id: json['id'] as String,
      city: PlaceResult.fromJson(json['city'] as Map<String, dynamic>),
      title: json['title'] as String,
      socialSource: (json['socialSource'] as List<dynamic>)
          .map((e) => SocialSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecommendationModelToJson(
        RecommendationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'title': instance.title,
      'description': instance.description,
      'socialSource': instance.socialSource,
    };
