import 'package:flutter/material.dart';

class FirstStepContent extends StatelessWidget {
  const FirstStepContent({
    required this.city,
    required this.title,
    required this.description,
    super.key,
  });

  final TextEditingController city;
  final TextEditingController title;
  final TextEditingController description;

  @override
  Widget build(BuildContext context) {
    print('BUILD first');

    return Column(
      children: [
        TextField(
          controller: city,
          decoration: const InputDecoration(
            label: Text('CITY'),
          ),
        ),
        TextField(
          controller: title,
          decoration: const InputDecoration(
            label: Text('TITLE'),
          ),
        ),
        TextField(
          controller: description,
          decoration: const InputDecoration(
            label: Text('DESCRIPTION'),
          ),
        ),
      ],
    );
  }
}
