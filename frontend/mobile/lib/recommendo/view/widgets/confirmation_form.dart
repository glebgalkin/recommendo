import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/view/widgets/wizard_buttons.dart';

class ConfirmationForm extends StatelessWidget {
  const ConfirmationForm({super.key});

  @override
  Widget build(BuildContext context) {
    const controllers = Row(
      children: [
        MoveBackButton(),
      ],
    );
    final children = [
      const SizedBox(height: 16),
      const Placeholder(fallbackHeight: 200),
      const Spacer(),
      controllers,
      const SizedBox(height: 32),
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
