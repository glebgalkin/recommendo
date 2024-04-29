import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';

abstract class RecommendationService {
  Future<AppResponse<bool>> createRecommendation({
    required PlaceResult city,
    required String title,
    required SocialLinkType type,
    required String link,
    String? description,
  });

  Future<AppResponse<List<RecommendedPlaceModel>>> getRecommendations({
    required PlaceResult cityResult,
    int offset = 0,
    int limit = 10,
    String? term,
  });

  Future<AppResponse<RecommendedPlaceModel>> getRecommendation({
    required String id,
  });
}
