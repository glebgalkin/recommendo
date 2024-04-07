import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/auth/view/profile_page.dart';
import 'package:recommendo/auth/view/sign_in_page.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/recommendo/view/home_page.dart';

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
    // GoRoute(
    //   path: AppPaths.wizzard,
    //   pageBuilder: (context, state) => containerTransform(
    //     state.pageKey,
    //     const CreatingWizardPage(),
    //   ),
    // ),
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

CustomTransitionPage<dynamic> containerTransform(LocalKey key, Widget child) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        SharedAxisTransition(
      transitionType: SharedAxisTransitionType.horizontal,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    ),
  );
}
