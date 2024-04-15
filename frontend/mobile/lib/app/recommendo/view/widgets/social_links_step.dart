import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recommendo/app/recommendo/view/widgets/responsive_page.dart';
import 'package:recommendo/app/recommendo/view/widgets/social_links_form.dart';
import 'package:recommendo/theme/app_texts.dart';

class SocialLinksStep extends StatelessWidget {
  const SocialLinksStep({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: const Column(
          children: [
            SizedBox(height: 24),
            AppTitle(text: '2 / 3'),
            SizedBox(height: 30),
            SocialLinksForm(),
          ],
        ),
      ),
    );
  }
}
