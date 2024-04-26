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
      leading: Image.network(
        'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
      ),
      title: Text(
        recommendation.title,
        style: textTheme.headlineSmall,
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
      subtitle: Text(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        recommendation.description,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
