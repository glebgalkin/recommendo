import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/navigation/app_paths.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: Text(context.l10n.profilePageAppBarTitle),
      ),
      actions: [
        SignedOutAction((context) => context.go(AppPaths.signInPage)),
      ],
    );
  }
}
