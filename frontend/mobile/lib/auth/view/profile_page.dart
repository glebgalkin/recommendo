import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/navigation/app_paths.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      actions: [
        SignedOutAction((context) => context.go(AppPaths.signInPage)),
      ],
    );
  }
}
