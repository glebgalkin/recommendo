import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/navigation/app_paths.dart';

class RecommendationsListItem extends StatelessWidget {
  const RecommendationsListItem({required this.recommendation, super.key});

  final RecommendationModel recommendation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () => context.go(
        AppPaths.recommendationDetailsPath(recommendation.id),
      ),
      leading: Text(recommendation.id, style: textTheme.bodySmall),
      title: Text(recommendation.title),
      isThreeLine: true,
      subtitle: Text(recommendation.title),
    );
  }
}
