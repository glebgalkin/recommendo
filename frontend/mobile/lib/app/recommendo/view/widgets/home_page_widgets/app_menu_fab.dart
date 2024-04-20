import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/auth/service/app_auth_controller.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/logout_dialog.dart';
import 'package:recommendo/common/expandable_fab/action_button.dart';
import 'package:recommendo/common/expandable_fab/expandable_fab.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class AppMenuFab extends StatelessWidget {
  const AppMenuFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 70,
      children: [
        // Create recommendation
        FabActionButton(
          onTap: () => context.go(AppPaths.wizzard),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        // Profile
        FabActionButton(
          onTap: () => context.go(AppPaths.profilePage),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.account_circle,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        // Logout
        FabActionButton(
          onTap: () async {
            final doLogout = await showModal<bool>(
              context: context,
              builder: (_) => const LogoutDialog(),
            );
            if (doLogout != null && doLogout == true) {
              await getIt<AppAuthController>().signOut();
              if (context.mounted) context.go(AppPaths.signInPage);
            }
          },
          backgroundColor: Theme.of(context).colorScheme.error,
          child: Icon(
            Icons.logout,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ],
    );
  }
}