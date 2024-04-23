import 'package:equatable/equatable.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';

class RecommendationModel extends Equatable {
  final String id;
  final PlaceResult city;
  final String title;
  final String? description;
  final List<SocialSource> socialSource;

  const RecommendationModel({
    required this.id,
    required this.city,
    required this.title,
    required this.socialSource,
    this.description,
  });

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
