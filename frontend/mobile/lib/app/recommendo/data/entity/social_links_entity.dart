import 'package:json_annotation/json_annotation.dart';

part 'social_links_entity.g.dart';

@JsonSerializable()
class SocialLinksEntity {
  SocialLinksEntity({
    required this.instagram,
    required this.facebook,
    required this.telegram,
    required this.webSite,
  });

  final String instagram;
  final String facebook;
  final String telegram;
  final String webSite;

  factory SocialLinksEntity.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinksEntityToJson(this);
}
