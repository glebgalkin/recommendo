import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/auth/view/profile_page.dart';
import 'package:recommendo/app/auth/view/service/app_auth_controller.dart';
import 'package:recommendo/app/auth/view/sign_in_page.dart';
import 'package:recommendo/app/recommendo/view/home_page.dart';
import 'package:recommendo/app/recommendo/view/recommendation_details_page.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/service_locator/service_locator.dart';

final router = GoRouter(
  initialLocation: AppPaths.homePage,
  redirect: (context, state) {
    if (!getIt<AppAuthController>().isLogged()) {
      return AppPaths.signInPage;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppPaths.homePage,
      pageBuilder: (context, state) => fadeThrough(
        state.pageKey,
        const HomePage(),
      ),
      routes: [
        GoRoute(
          path: AppPaths.recommendationDetails,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'];
            return fadeThrough(
              state.pageKey,
              RecommendationDetailsPage(id: id!),
            );
          },
        ),
        GoRoute(
          path: AppPaths.profilePage.substring(1),
          pageBuilder: (context, state) => fadeThrough(
            state.pageKey,
            const ProfilePage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppPaths.signInPage,
      pageBuilder: (context, state) => fadeThrough(
        state.pageKey,
        const SignInPage(),
      ),
    ),
  ],
);

CustomTransitionPage<dynamic> fadeThrough(LocalKey key, Widget child) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    ),
  );
}
