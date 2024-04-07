import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/recommendo/service/model/social_links_model.dart';

abstract class RecommendationsRepository {
  Future<AppResponse<RecommendationModel>> getRecommendation(String id);

  Future<AppResponse<bool>> createRecommendation({
    required String city,
    required String title,
    required SocialLinks links,
    String? description,
  });

  Future<AppResponse<bool>> deleteRecommendation(String id);

  Future<AppResponse<List<RecommendationModel>>> getRecommendations();
}
