import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/l10n/l10n.dart';

class CleanFormDialog extends StatelessWidget {
  const CleanFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.clearFormDialogTitle),
      content: Text(l10n.clearFormDialogContent),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(l10n.clearFormDialogCancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(l10n.clearFormDialogConfirm),
        ),
      ],
    );
  }
}
