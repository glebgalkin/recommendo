import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/navigation/app_paths.dart';

class RecommendationsListItem extends StatelessWidget {
  const RecommendationsListItem({required this.recommendation, super.key});

  final RecommendedPlaceModel recommendation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () => context.go(
        AppPaths.recommendationDetailsPath(recommendation.id),
      ),
      title: Text(
        recommendation.title,
        style: textTheme.headlineMedium,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                recommendation.rating.toString(),
                style: textTheme.labelLarge,
              ),
              const Icon(Icons.star),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                recommendation.uniqueRecommendations.toString(),
                style: textTheme.labelLarge,
              ),
              const Icon(Icons.contact_emergency),
            ],
          ),
        ],
      ),
      isThreeLine: true,
      subtitle: Text(recommendation.description),
    );
  }
}
