import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';

abstract class RecommendationsRepository {
  Future<AppResponse<RecommendationModel>> getRecommendation(String id);

  Future<AppResponse<bool>> createRecommendation({
    required CityResult city,
    required String title,
    required String link,
    String? description,
  });

  Future<AppResponse<bool>> deleteRecommendation(String id);

  Future<AppResponse<List<RecommendationModel>>> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  });
}
