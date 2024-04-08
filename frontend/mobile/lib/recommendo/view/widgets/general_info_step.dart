import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/view/widgets/general_info_form.dart';
import 'package:recommendo/theme/app_texts.dart';

class GeneralInfoStep extends StatelessWidget {
  const GeneralInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 24),
        AppTitle(text: '1 / 3'),
        SizedBox(height: 48),
        GeneralInfoForm(),
      ],
    );
  }
}
