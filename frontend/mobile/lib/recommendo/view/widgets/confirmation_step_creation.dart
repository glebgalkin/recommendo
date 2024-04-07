import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';

class ConfirmationStepContent extends StatelessWidget {
  const ConfirmationStepContent({super.key});

  @override
  Widget build(BuildContext context) {
    print('BUILD confirmation');
    final bloc = context.read<StepperBloc>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('City'),
            Text(bloc.cityText.text),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Title'),
            Text(bloc.titleText.text),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Description'),
            Text(bloc.descriptionText.text),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('social'),
            Text(bloc.socialLinks.text),
          ],
        ),
      ],
    );
  }
}
