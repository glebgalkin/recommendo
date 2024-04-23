class SocialSource {
  final String id;
  final SocialLinkType type;
  final dynamic extra;

  const SocialSource({
    required this.id,
    required this.type,
    required this.extra,
  });
}

enum SocialLinkType {
  instagram,
  googleMaps,
  unknown,
}
