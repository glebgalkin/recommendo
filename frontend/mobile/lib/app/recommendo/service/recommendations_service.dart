import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';

class RecommendationService {
  final RecommendationsRepository _repository;

  const RecommendationService(this._repository);

  Future<AppResponse<bool>> saveRecommendation({
    required CityResult city,
    required String title,
    required SocialLinks links,
    String? description,
  }) {
    return _repository.createRecommendation(
      city: city,
      title: title,
      links: links,
      description: description,
    );
  }

  Future<AppResponse<List<RecommendationModel>>> getRecommendations({
    required CityResult cityResult,
    int offset = 0,
    int limit = 5,
    String? term,
  }) {
    return _repository.getRecommendations(
      offset: offset,
      limit: limit,
      cityId: cityResult.value,
      term: term,
    );
  }
}
