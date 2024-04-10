import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/recommendo/view/widgets/confirmation_step.dart';
import 'package:recommendo/recommendo/view/widgets/general_info_step.dart';
import 'package:recommendo/recommendo/view/widgets/social_links_step.dart';

class CreatingRecommendationPage extends StatelessWidget {
  const CreatingRecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StepperBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recommendo'),
      ),
      body: SafeArea(
        child: BlocBuilder<StepperBloc, StepperState>(
          bloc: bloc,
          buildWhen: (previous, current) => previous.step != current.step,
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
                0 => const GeneralInfoStep(),
                1 => const SocialLinksStep(),
                2 => const ConfirmationStep(),
                _ => const SizedBox.shrink(),
              },
            );
          },
        ),
      ),
    );
  }
}
