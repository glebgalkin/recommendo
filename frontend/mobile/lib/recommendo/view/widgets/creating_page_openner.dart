import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/recommendo/view/creating_page.dart';

class CreatingPageOpenner extends StatefulWidget {
  const CreatingPageOpenner({super.key});

  @override
  State<CreatingPageOpenner> createState() => _CreatingPageOpennerState();
}

class _CreatingPageOpennerState extends State<CreatingPageOpenner> {
  static const _fab = 56.0;
  StepperBloc? _stepperBloc;

  StepperBloc get stepperBloc {
    _stepperBloc ??= StepperBloc();
    return _stepperBloc!;
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool?>(
      routeSettings: const RouteSettings(name: AppPaths.wizzard),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Durations.extralong1,
      onClosed: (value) {
        if (value ?? false) {
          stepperBloc.dispose();
          _stepperBloc = null;
        }
      },
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
          value: stepperBloc,
          child: CreatingRecommendationPage(
            closeContainer: closeContainer,
          ),
        );
      },
    );
  }
}
