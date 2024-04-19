import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

class RecommendationService {
  final RecommendationsRepository _repository;

  const RecommendationService(this._repository);

  Future<AppResponse<bool>> saveRecommendation({
    required PlaceResult city,
    required String title,
    required SocialLinkType type,
    required String link,
    String? description,
  }) {
    return _repository.createRecommendation(
      city: city,
      title: title,
      type: type.toString(),
      link: link,
    );
  }

  Future<AppResponse<List<RecommendationModel>>> getRecommendations({
    required PlaceResult cityResult,
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
