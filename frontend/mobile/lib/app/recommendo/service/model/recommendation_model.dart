import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
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

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationModelToJson(this);
}
