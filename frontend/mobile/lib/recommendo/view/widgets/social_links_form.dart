import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/recommendo/view/widgets/wizard_buttons.dart';

class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  SocialLinksFormState createState() => SocialLinksFormState();
}

class SocialLinksFormState extends State<SocialLinksForm> {
  final instagram = TextEditingController();
  final facebook = TextEditingController();
  final website = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stepperBloc = context.read<StepperBloc>();
    instagram.text = stepperBloc.state.instagram;
    facebook.text = stepperBloc.state.facebook;
    website.text = stepperBloc.state.website;

    final controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MoveBackButton(
          onPressed: () => stepperBloc.add(MoveBack()),
        ),
        MoveForwardButton(
          onPressed: () => stepperBloc.add(
            SubmitSocialLinks(
              instagram: instagram.text,
              facebook: facebook.text,
              website: website.text,
            ),
          ),
        ),
      ],
    );

    final children = [
      const SizedBox(height: 16),
      TextField(
        controller: instagram,
        decoration: const InputDecoration(
          label: Text('Instagram'),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: facebook,
        decoration: const InputDecoration(
          label: Text('Facebook'),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: website,
        decoration: const InputDecoration(
          label: Text('Web site'),
        ),
      ),
      const SizedBox(height: 32),
      controllers,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: stepperBloc.socialLinksFormKey,
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    instagram.dispose();
    facebook.dispose();
    website.dispose();
  }
}
