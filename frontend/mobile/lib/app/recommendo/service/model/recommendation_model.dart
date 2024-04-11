// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:recommendo/app/recommendo/service/model/social_links_model.dart';

class RecommendationModel extends Equatable {
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

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
