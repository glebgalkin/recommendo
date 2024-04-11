import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/common/app_response.dart';

class RecommendationService {
  final RecommendationsRepository _repository;

  const RecommendationService(this._repository);

  Future<AppResponse<bool>> saveRecommendation({
    required String city,
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
    int offset = 0,
    int limit = 15,
  }) {
    return _repository.getRecommendations(offset: offset, limit: limit);
  }
}
