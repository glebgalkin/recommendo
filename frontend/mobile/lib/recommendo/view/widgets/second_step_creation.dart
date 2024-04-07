import 'package:flutter/material.dart';

class SecondStepCreation extends StatefulWidget {
  const SecondStepCreation({super.key});

  @override
  State<SecondStepCreation> createState() => _CityStepContentState();
}

class _CityStepContentState extends State<SecondStepCreation> {
  @override
  Widget build(BuildContext context) {
    print('BUILD SECOND');
    return const TextField(
      minLines: 3,
      maxLines: 5,
      decoration: InputDecoration(
        label: Text('SOCIAL LINKS'),
      ),
    );
  }
}
