import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';

abstract class RecommendationsRepository {
  Future<RecommendationModel> getRecommendation(String id);

  Future<bool> createRecommendation({
    required PlaceResult city,
    required String title,
    required String type,
    required String link,
    String? description,
  });

  Future<bool> deleteRecommendation(String id);

  Future<List<RecommendationModel>> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  });
}
