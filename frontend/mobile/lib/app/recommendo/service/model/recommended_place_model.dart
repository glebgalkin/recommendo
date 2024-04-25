import 'package:recommendo/app/recommendo/service/model/social_source.dart';

class RecommendedPlaceModel {
  final String id;
  final String title;
  final String description;
  final List<SocialSource> sources;
  final double rating;
  final int uniqueRecommendations;

  const RecommendedPlaceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sources,
    required this.rating,
    required this.uniqueRecommendations,
  });
}
