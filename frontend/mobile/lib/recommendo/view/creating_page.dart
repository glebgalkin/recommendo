import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/recommendo/view/widgets/bottom_controllers.dart';
import 'package:recommendo/recommendo/view/widgets/confirmation_step_creation.dart';
import 'package:recommendo/recommendo/view/widgets/first_step_creation.dart';
import 'package:recommendo/recommendo/view/widgets/second_step_creation.dart';

class CreatingRecommendationPage extends StatelessWidget {
  const CreatingRecommendationPage({required this.closeContainer, super.key});

  final CloseContainerActionCallback<String> closeContainer;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StepperBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recommendo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            closeContainer(returnValue: 'some string');
          },
        ),
      ),
      body: BottomControllers(
        child: BlocBuilder<StepperBloc, StepperState>(
          bloc: bloc,
          builder: (context, state) {
            return PageTransitionSwitcher(
              reverse: state.reverseAnimation,
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  transitionType: SharedAxisTransitionType.horizontal,
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: switch (state.step) {
                0 => FirstStepContent(
                    city: bloc.cityText,
                    title: bloc.titleText,
                    description: bloc.descriptionText,
                  ),
                1 => const SecondStepCreation(),
                2 => const ConfirmationStepContent(),
                _ => const SizedBox.shrink(),
              },
            );
          },
        ),
      ),
    );
  }
}
