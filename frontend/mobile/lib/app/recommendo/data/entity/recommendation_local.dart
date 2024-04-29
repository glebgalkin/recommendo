import 'package:hive/hive.dart';

part 'recommendation_local.g.dart';

@HiveType(typeId: 0)
class RecommendationLocalModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String cityId;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String img;
  @HiveField(6)
  final List<SocialSourceLocal> socialSource;
  @HiveField(7)
  final int recommendedCount;

  const RecommendationLocalModel({
    required this.id,
    required this.cityId,
    required this.title,
    required this.description,
    required this.img,
    required this.socialSource,
    required this.recommendedCount,
  });
}

@HiveType(typeId: 2)
class SocialSourceLocal {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type;

  const SocialSourceLocal({
    required this.id,
    required this.type,
  });
}
