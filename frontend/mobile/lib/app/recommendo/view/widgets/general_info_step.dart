import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/general_info_form.dart';
import 'package:recommendo/app/recommendo/view/widgets/responsive_page.dart';
import 'package:recommendo/theme/app_texts.dart';

class GeneralInfoStep extends StatelessWidget {
  const GeneralInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: const Column(
          children: [
            SizedBox(height: 24),
            AppTitle(text: '1 / 3'),
            SizedBox(height: 48),
            GeneralInfoForm(),
          ],
        ),
      ),
    );
  }
}