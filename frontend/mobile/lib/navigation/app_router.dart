import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/auth/view/profile_page.dart';
import 'package:recommendo/app/auth/view/sign_in_page.dart';
import 'package:recommendo/app/recommendo/view/home_page.dart';
import 'package:recommendo/app/recommendo/view/recommendation_details_page.dart';
import 'package:recommendo/navigation/app_paths.dart';

final router = GoRouter(
  initialLocation: AppPaths.homePage,
  redirect: (context, state) {
    final isLogged = FirebaseAuth.instance.currentUser != null;
    if (!isLogged) {
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
      ],
    ),
    GoRoute(
      path: AppPaths.signInPage,
      pageBuilder: (context, state) => fadeThrough(
        state.pageKey,
        const SignInPage(),
      ),
    ),
    GoRoute(
      path: AppPaths.profilePage,
      pageBuilder: (context, state) => fadeThrough(
        state.pageKey,
        const ProfilePage(),
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
