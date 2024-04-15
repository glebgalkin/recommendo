import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/app/recommendo/data/entity/social_links_entity.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';

part 'recommendation_payload_entity.g.dart';

@JsonSerializable()
class RecommendationPayloadEntity {
  final CityResult city;
  final String title;
  final String? description;
  final SocialLinksEntity socialLinks;

  const RecommendationPayloadEntity({
    required this.city,
    required this.title,
    required this.socialLinks,
    this.description,
  });

  factory RecommendationPayloadEntity.fromJson(Map<String, dynamic> json) =>
      _$RecommendationPayloadEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationPayloadEntityToJson(this);
}
