import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/auth/service/app_auth_controller.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/clear_cache_dialog.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/expandable_fab/action_button.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/expandable_fab/expandable_fab.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/logout_dialog.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/common/snack_bar_extensions.dart';
import 'package:recommendo/l10n/l10n.dart';
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
          heroTag: FabHeroTag.createRecommendation.toString(),
          onTap: () async {
            final result = await context.push(AppPaths.wizzard);
            if (context.mounted && result == true) {
              final msg = context.l10n.recommendationCreatedSucessMsg;
              context.snackBarSuccessMsg(msg);
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        // Profile
        FabActionButton(
          heroTag: FabHeroTag.profile.toString(),
          onTap: () => context.go(AppPaths.profilePage),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.account_circle,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        // Clear cache
        FabActionButton(
          heroTag: FabHeroTag.clearCache.toString(),
          onTap: () async {
            final doClearCache = await showModal<bool>(
              context: context,
              builder: (_) => const ClearCacheDialog(),
            );
            if (doClearCache != null && doClearCache == true) {
              final result = await getIt<RecommendationService>().clearCache();

              if (!context.mounted) return;

              if (result.error != null) {
                final localizedError =
                    localizedErrorText(result.error!.code, context.l10n);
                context.snackBarErrorMsg(localizedError);
              } else {
                final successMsg =
                    context.l10n.successfullyCleared(result.result!);
                context.snackBarSuccessMsg(successMsg);
              }
            }
          },
          backgroundColor: Theme.of(context).colorScheme.error,
          child: Icon(
            Icons.delete,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        // Logout
        FabActionButton(
          heroTag: FabHeroTag.logout.toString(),
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

enum FabHeroTag {
  open,
  close,
  createRecommendation,
  profile,
  clearCache,
  logout,
}
