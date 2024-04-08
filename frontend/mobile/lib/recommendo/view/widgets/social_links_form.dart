import 'package:flutter/material.dart';
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
    const controllers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MoveBackButton(),
        MoveForwardButton(disabled: false),
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
