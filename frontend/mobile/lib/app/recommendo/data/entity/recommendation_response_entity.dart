import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/app/recommendo/data/entity/social_links_entity.dart';

part 'recommendation_response_entity.g.dart';

@JsonSerializable()
class RecommendationResponseEntity {
  final String id;
  final String title;
  final String description;
  final SocialLinksEntity socialLinks;
  final String city;
  final String address;

  const RecommendationResponseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.socialLinks,
    required this.city,
    required this.address,
  });

  factory RecommendationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationResponseEntityToJson(this);
}
