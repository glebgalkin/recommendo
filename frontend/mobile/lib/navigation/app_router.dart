import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_advertisment/auth/view/profile_page.dart';
import 'package:minimal_advertisment/auth/view/sign_in_page.dart';
import 'package:minimal_advertisment/navigation/app_paths.dart';

final router = GoRouter(
  initialLocation: AppPaths.signInPage,
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
      pageBuilder: (context, state) => appDefault(
        state.pageKey,
        const Placeholder(),
      ),
    ),
    GoRoute(
      path: AppPaths.signInPage,
      pageBuilder: (context, state) => appDefault(
        state.pageKey,
        const SignInPage(),
      ),
    ),
    GoRoute(
      path: AppPaths.profilePage,
      pageBuilder: (context, state) => appDefault(
        state.pageKey,
        const ProfilePage(),
      ),
    ),
  ],
);

CustomTransitionPage<dynamic> appDefault(LocalKey key, Widget child) {
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
