import 'package:recommendo/recommendo/service/model/social_links_model.dart';

class RecommendationModel {
  final String id;
  final String title;
  final String description;
  final SocialLinks socialLinks;
  final String city;
  final String address;

  const RecommendationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.socialLinks,
    required this.city,
    required this.address,
  });
}
