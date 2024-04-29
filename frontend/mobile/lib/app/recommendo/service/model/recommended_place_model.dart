import 'package:recommendo/app/recommendo/service/model/social_source.dart';

class RecommendedPlaceModel {
  final String id;
  final String title;
  final String description;
  final String img;
  final List<SocialSource> sources;
  final int recommendedCount;

  const RecommendedPlaceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
    required this.sources,
    required this.recommendedCount,
  });
}
