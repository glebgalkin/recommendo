import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/creation/bloc/stepper_bloc.dart';

class BottomControllers extends StatelessWidget {
  const BottomControllers({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.read<StepperBloc>().add(StepCancelled()),
          icon: const Icon(Icons.abc_sharp),
        ),
        IconButton(
          onPressed: () => context.read<StepperBloc>().add(StepContinue()),
          icon: const Icon(Icons.accessible_forward_sharp),
        ),
      ],
    );

    return Column(
      children: [
        const Spacer(),
        child,
        const Spacer(),
        controllers,
      ],
    );
  }
}
