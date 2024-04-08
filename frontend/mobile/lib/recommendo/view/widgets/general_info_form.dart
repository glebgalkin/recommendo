import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/view/widgets/autocomplete_city.dart';
import 'package:recommendo/recommendo/view/widgets/wizard_buttons.dart';

class GeneralInfoForm extends StatefulWidget {
  const GeneralInfoForm({super.key});

  @override
  State<GeneralInfoForm> createState() => GeneralInfoFormState();
}

class GeneralInfoFormState extends State<GeneralInfoForm> {
  final city = TextEditingController();
  final title = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const controllers = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MoveForwardButton(disabled: false),
      ],
    );
    final children = [
      CityAutocompleteField(controller: city),
      const SizedBox(height: 16),
      TextField(
        controller: title,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: description,
        decoration: const InputDecoration(
          label: Text('Description: Optional'),
        ),
      ),
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

  @override
  void dispose() {
    super.dispose();
    city.dispose();
    title.dispose();
    description.dispose();
  }
}
