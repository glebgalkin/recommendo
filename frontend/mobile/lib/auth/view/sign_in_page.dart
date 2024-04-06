import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/auth/view/widgets/app_logo.dart';
import 'package:recommendo/common/snack_bar_extensions.dart';
import 'package:recommendo/navigation/app_paths.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      headerBuilder: (context, constraints, shrinkOffset) => const AppLogo(),
      oauthButtonVariant: OAuthButtonVariant.icon,
      actions: [
        AuthStateChangeAction<SignedIn>(
          (context, state) => context.go(AppPaths.homePage),
        ),
        AuthStateChangeAction<UserCreated>(
          (context, state) => context.go(AppPaths.profilePage),
        ),
        AuthStateChangeAction<AuthFailed>(
          (context, state) => context.snackBarError(state.exception),
        ),
      ],
    );
  }
}
