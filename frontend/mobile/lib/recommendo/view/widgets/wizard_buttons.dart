import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';

class MoveForwardButton extends StatelessWidget {
  const MoveForwardButton({
    required this.disabled,
    super.key,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Text('Continue'),
      onPressed: disabled
          ? null
          : () => context.read<StepperBloc>().add(MoveForward()),
      label: const Icon(Icons.arrow_forward),

      //style: style,
    );
  }
}

class MoveBackButton extends StatelessWidget {
  const MoveBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => context.read<StepperBloc>().add(MoveBack()),
      label: const Text('Back'),
    );
  }
}
