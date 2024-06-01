import 'package:realm/realm.dart';

part 'recommendation_local.realm.dart';

@RealmModel()
class _RecommendationLocalModel {
  @Indexed()
  late String id;
  @Indexed()
  late String cityId;
  @Indexed(RealmIndexType.fullText)
  late String title;
  @Indexed(RealmIndexType.fullText)
  late String description;
  late String img;
  late List<_SocialSourceLocal> socialSource;
  late int recommendedCount;
}

@RealmModel(ObjectType.embeddedObject)
class _SocialSourceLocal {
  late String? id;
  late String? type;
}
