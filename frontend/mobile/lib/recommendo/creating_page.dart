import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/service/aws_repository.dart';

class CreatingWizardPage extends StatelessWidget {
  const CreatingWizardPage({required this.closeContainer, super.key});

  final CloseContainerActionCallback<String> closeContainer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('create'),
          ),
          IconButton(
            onPressed: () {
              closeContainer(returnValue: 'TITLE');
            },
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              AwsRepository().sendRequest();
            },
            icon: const Icon(Icons.dangerous),
          ),
        ],
      ),
    );
  }
}
