import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/auth/view/service/app_auth_controller.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/creating_page_openner.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/action_button.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/floating_app_menu.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/recommendations_list.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/search_app_bar.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const CustomScrollView(
            slivers: [
              SearchAppBar(),
              RecommendationsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingAppMenu(
        distance: 100,
        children: [
          const CreatingPageOpenner(),
          ActionButton(
            onPressed: () {
              getIt<AppAuthController>().signOut();
              context.go(AppPaths.signInPage);
            },
            icon: const Icon(Icons.logout),
          ),
          ActionButton(
            onPressed: () => context.go(AppPaths.profilePage),
            icon: const Icon(Icons.audio_file_sharp),
          ),
        ],
      ),
    );
  }
}
