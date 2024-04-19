import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/confirmation_form.dart';
import 'package:recommendo/app/recommendo/view/widgets/responsive_page.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/theme/app_texts.dart';

class ConfirmationStep extends StatelessWidget {
  const ConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            const SizedBox(height: 24),
            AppTitle(text: context.l10n.confirmationHelperTitle),
            const SizedBox(height: 30),
            Text(context.l10n.confirmationHelperText),
            const SizedBox(height: 16),
            const ConfirmationForm(),
          ],
        ),
      ),
    );
  }
}
