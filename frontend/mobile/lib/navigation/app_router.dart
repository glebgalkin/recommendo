import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/auth/service/app_auth_controller.dart';
import 'package:recommendo/app/auth/view/profile_page.dart';
import 'package:recommendo/app/auth/view/sign_in_page.dart';
import 'package:recommendo/app/recommendo/view/home_page.dart';
import 'package:recommendo/app/recommendo/view/recommendation_creation_page.dart';
import 'package:recommendo/app/recommendo/view/recommendation_details_page.dart';
import 'package:recommendo/navigation/app_paths.dart';
import 'package:recommendo/service_locator/service_locator.dart';

final router = GoRouter(
  initialLocation: AppPaths.homePage,
  refreshListenable: RouterAuthStateStream(
    getIt<AppAuthController>().authStateChanges(),
  ),
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
          path: AppPaths.recommendationDetails.substring(1),
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
        GoRoute(
          path: AppPaths.wizzard.substring(1),
          pageBuilder: (context, state) => fadeThrough(
            state.pageKey,
            const RecommendationCreationPage(),
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

class RouterAuthStateStream extends ChangeNotifier {
  late final StreamSubscription<bool> _subscription;

  RouterAuthStateStream(Stream<bool> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
