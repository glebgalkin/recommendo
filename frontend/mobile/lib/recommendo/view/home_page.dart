import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/recommendo/view/creating_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const _fab = 56.0;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StepperBloc? _stepperBloc;

  StepperBloc get stepperBloc {
    _stepperBloc ??= StepperBloc(
      maxSteps: 3,
      cityText: TextEditingController(),
      titleText: TextEditingController(),
      descriptionText: TextEditingController(),
      socialLinks: TextEditingController(),
    );
    return _stepperBloc!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OpenContainer<String?>(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: Durations.extralong1,
        onClosed: (value) {
          if (value != 'some string') {
            stepperBloc.dispose();
            _stepperBloc = null;
          }
        },
        useRootNavigator: true,
        closedElevation: 6,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(HomePage._fab / 2),
          ),
        ),
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (context, _) => SizedBox.square(
          dimension: HomePage._fab,
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
      ),
    );
  }
}
