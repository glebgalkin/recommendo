import 'package:hive/hive.dart';
import 'package:recommendo/recommendo/data/entity/recommendation_response_entity.dart';

class RecommendationsLocal {
  final Box<RecommendationResponseEntity> _recommendationsBox;

  const RecommendationsLocal(this._recommendationsBox);

  Future<void> saveRecommendation(RecommendationResponseEntity entity) async {
    await _recommendationsBox.put(entity.id, entity);
  }

  RecommendationResponseEntity? getRecommendation(String id) {
    return _recommendationsBox.get(id);
  }
}
