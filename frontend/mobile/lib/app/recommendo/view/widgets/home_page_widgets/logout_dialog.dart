import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/l10n/l10n.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.logoutDialogTitle),
      content: Text(l10n.logoutDialogContent),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(l10n.logoutDialogCancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            l10n.logoutDialogConfirm,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}
