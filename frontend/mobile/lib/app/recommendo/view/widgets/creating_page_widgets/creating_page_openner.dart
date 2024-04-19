import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/creating_page.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/service_locator/service_locator.dart';

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
      openBuilder: (context, closeContainer) {
        return BlocProvider.value(
          value: getIt<CreateRecommendationCubit>(),
          child: const CreatingRecommendationPage(),
        );
      },
    );
  }
}
