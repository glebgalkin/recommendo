import 'package:json_annotation/json_annotation.dart';

part 'social_source.g.dart';

@JsonSerializable()
class SocialSource {
  final String id;
  final SocialLinkType type;

  const SocialSource({required this.id, required this.type});

  factory SocialSource.fromJson(Map<String, dynamic> json) =>
      _$SocialSourceFromJson(json);

  Map<String, dynamic> toJson() => _$SocialSourceToJson(this);
}

enum SocialLinkType {
  instagram,
  googleMaps,
}
