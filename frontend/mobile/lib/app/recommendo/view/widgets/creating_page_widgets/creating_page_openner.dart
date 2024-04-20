import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/recommendation_creation_page.dart';
import 'package:recommendo/navigation/app_paths.dart';

class CreatingPageOpenner extends StatelessWidget {
  static const _fab = 56.0;

  const CreatingPageOpenner({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool?>(
      routeSettings: const RouteSettings(name: AppPaths.wizzard),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Durations.extralong1,
      useRootNavigator: true,
      closedElevation: 6,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_fab / 2),
        ),
      ),
      closedColor: Theme.of(context).primaryColor,
      closedBuilder: (context, _) => SizedBox.square(
        dimension: _fab,
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      openBuilder: (_, __) => const RecommendationCreationPage(),
    );
  }
}
