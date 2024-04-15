import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/general_info_form.dart';
import 'package:recommendo/app/recommendo/view/widgets/responsive_page.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/theme/app_texts.dart';

class GeneralInfoStep extends StatelessWidget {
  const GeneralInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            const SizedBox(height: 24),
            AppTitle(text: context.l10n.generalInfoHelperTitle),
            const SizedBox(height: 30),
            Text(context.l10n.generalInfoHelperText),
            const SizedBox(height: 16),
            const GeneralInfoForm(),
          ],
        ),
      ),
    );
  }
}
