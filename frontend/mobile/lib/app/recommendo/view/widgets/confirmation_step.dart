import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/confirmation_form.dart';
import 'package:recommendo/app/recommendo/view/widgets/responsive_page.dart';
import 'package:recommendo/theme/app_texts.dart';

class ConfirmationStep extends StatelessWidget {
  const ConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: const Column(
          children: [
            SizedBox(height: 24),
            AppTitle(text: '3 / 3'),
            SizedBox(height: 48),
            ConfirmationForm(),
          ],
        ),
      ),
    );
  }
}
