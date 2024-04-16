import 'package:equatable/equatable.dart';

class RecommendationModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String socialLink;
  final String city;
  final String address;

  const RecommendationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.socialLink,
    required this.city,
    required this.address,
  });

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
