import 'package:hive/hive.dart';

part 'recommendation_local.g.dart';

@HiveType(typeId: 0)
class RecommendationLocalModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String cityId;
  @HiveField(2)
  final String cityName;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String? description;
  //final List<SocialSource> socialSource;

  const RecommendationLocalModel({
    required this.id,
    required this.cityId,
    required this.cityName,
    required this.title,
//required this.socialSource,
    this.description,
  });
}
