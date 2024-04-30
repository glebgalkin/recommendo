import 'package:isar/isar.dart';

part 'recommendation_local.g.dart';

@collection
class RecommendationLocalModel {
  final String id;
  final String cityId;
  final String title;
  final String description;
  final String img;
  final List<SocialSourceLocal> socialSource;
  final int recommendedCount;

  @Index(caseSensitive: false)
  List<String> get contentWords => [
        ...Isar.splitWords(title),
        ...Isar.splitWords(description),
      ];

  const RecommendationLocalModel({
    required this.id,
    required this.cityId,
    required this.title,
    required this.description,
    required this.img,
    required this.socialSource,
    required this.recommendedCount,
  });

  Id get isarId => _fastHash(id);

  static int _fastHash(String string) {
    // ignore: avoid_js_rounded_ints
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}

@embedded
class SocialSourceLocal {
  String? id;
  String? type;
}
