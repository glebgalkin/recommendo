import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/view/widgets/autocomplete_city.dart';

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
    return Column(
      children: [
        const Text('1 / 4'),
        const SizedBox(height: 50),
        AsyncAutocomplete(controller: city),
        const SizedBox(height: 50),
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
