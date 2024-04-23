import 'package:hive/hive.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';

class RecommendationsLocal {
  final Box<RecommendationLocalModel> _recommendationsBox;

  const RecommendationsLocal(this._recommendationsBox);

  Future<void> saveRecommendation(RecommendationLocalModel entity) {
    return _recommendationsBox.put(entity.id, entity);
  }

  RecommendationLocalModel? getRecommendation(String id) {
    return _recommendationsBox.get(id);
  }

  bool containsKey(String id) {
    return _recommendationsBox.containsKey(id);
  }

  Future<void> delete(String id) async {
    return _recommendationsBox.delete(id);
  }

  List<RecommendationLocalModel> getRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  }) {
    return _recommendationsBox.values
        .where((element) => element.cityId == cityId)
        .where(
          (element) =>
              term == null ||
              element.title.contains(term) ||
              element.description == null ||
              element.description!.contains(term),
        )
        .skip(offset)
        .take(limit)
        .toList();
  }
}
