class SocialSource {
  final String id;
  final SocialLinkType type;

  const SocialSource({
    required this.id,
    required this.type,
  });
}

enum SocialLinkType {
  instagram,
  googleMaps,
  unknown,
}
