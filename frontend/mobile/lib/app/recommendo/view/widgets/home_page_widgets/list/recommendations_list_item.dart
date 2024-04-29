import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/navigation/app_paths.dart';

class RecommendationsListItem extends StatelessWidget {
  const RecommendationsListItem({required this.recommendation, super.key});

  final RecommendedPlaceModel recommendation;

  @override
  Widget build(BuildContext context) {
    final imgWidget = CachedNetworkImage(
      cacheKey: recommendation.id,
      imageUrl: recommendation.img,
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        fit: BoxFit.cover,
      ),
      progressIndicatorBuilder: (_, __, ___) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => ColoredBox(
        color: Theme.of(context).colorScheme.outlineVariant,
        child: const Center(
          child: Icon(Icons.error_outline),
        ),
      ),
    );

    return GestureDetector(
      onTap: () =>
          context.go(AppPaths.recommendationDetailsPath(recommendation.id)),
      child: Card.filled(
        elevation: 2,
        child: RecommendedPlaceTile(
          thumbnail: imgWidget,
          title: recommendation.title,
          description: recommendation.description,
          recommendedCount: recommendation.recommendedCount,
          sources: recommendation.sources,
        ),
      ),
    );
  }
}

class RecommendedPlaceTile extends StatelessWidget {
  static const _tileHeight = 130.0;

  const RecommendedPlaceTile({
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.recommendedCount,
    required this.sources,
    super.key,
  });

  final Widget thumbnail;
  final String title;
  final String description;
  final int recommendedCount;
  final List<SocialSource> sources;

  @override
  Widget build(BuildContext context) {
    final thumbnailWidget = AspectRatio(
      aspectRatio: 0.9,
      child: thumbnail,
    );
    final bodyWidget = Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
        child: _RecommendedPlaceBody(
          title: title,
          description: description,
          recommendedCount: recommendedCount,
          sources: sources,
        ),
      ),
    );

    return SizedBox(
      height: _tileHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          thumbnailWidget,
          bodyWidget,
        ],
      ),
    );
  }
}

class _RecommendedPlaceBody extends StatelessWidget {
  const _RecommendedPlaceBody({
    required this.title,
    required this.description,
    required this.recommendedCount,
    required this.sources,
  });

  final String title;
  final String description;
  final int recommendedCount;
  final List<SocialSource> sources;

  @override
  Widget build(BuildContext context) {
    final sourcesIcons = <Widget>[];
    for (final source in sources) {
      final icon = switch (source.type) {
        SocialLinkType.instagram => const FaIcon(FontAwesomeIcons.instagram),
        SocialLinkType.googleMaps =>
          const FaIcon(FontAwesomeIcons.mapLocationDot),
        _ => null,
      };
      if (icon != null) {
        sourcesIcons
          ..add(icon)
          ..add(const SizedBox(width: 4));
      }
    }

    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleLarge,
        ),
        Expanded(
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ),
        Row(
          children: sourcesIcons,
        ),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          context.l10n.recommendedByMessage(recommendedCount),
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
