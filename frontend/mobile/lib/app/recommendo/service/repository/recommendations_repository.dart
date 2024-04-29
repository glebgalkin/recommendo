import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';

abstract class RecommendationsRepository {
  Future<RecommendedPlaceModel> getRecommendation(String id);

  Future<bool> createRecommendation({
    required String cityId,
    required String title,
    required SocialLinkType type,
    required String link,
    String? description,
  });

  Future<bool> deleteRecommendation(String id);

  Future<List<RecommendedPlaceModel>> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    bool searchOnDevice = false,
    String? term,
  });

  Future<int> clearCache();

  Future<int> getCacheSize();
}
