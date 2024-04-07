import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/recommendo/service/repository/recommendations_repository.dart';

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
}
