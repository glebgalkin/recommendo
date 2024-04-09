import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/recommendo/view/widgets/wizard_buttons.dart';

class ConfirmationForm extends StatelessWidget {
  const ConfirmationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = Row(
      children: [
        MoveBackButton(
          onPressed: () => context.read<StepperBloc>().add(MoveBack()),
        ),
      ],
    );
    final children = [
      const SizedBox(height: 16),
      const Placeholder(fallbackHeight: 200),
      const SizedBox(height: 32),
      controllers,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
