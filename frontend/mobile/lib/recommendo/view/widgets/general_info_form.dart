import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
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
  void initState() {
    super.initState();

    final stepperBloc = context.read<StepperBloc>();
    city.text = stepperBloc.state.city;
    title.text = stepperBloc.state.title;
    description.text = stepperBloc.state.description;
  }

  @override
  Widget build(BuildContext context) {
    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MoveForwardButton(
          onPressed: () => context.read<StepperBloc>().add(
                SumbitGeneralInfoForm(
                  city: city.text,
                  title: title.text,
                  description: description.text,
                ),
              ),
        ),
      ],
    );
    final children = [
      CityAutocompleteField(controller: city),
      const SizedBox(height: 16),
      TextFormField(
        controller: title,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Can't be empty";
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
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
        key: context.read<StepperBloc>().basicInfoFormKey,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  void dispose() {
    city.dispose();
    title.dispose();
    description.dispose();
    super.dispose();
  }
}
