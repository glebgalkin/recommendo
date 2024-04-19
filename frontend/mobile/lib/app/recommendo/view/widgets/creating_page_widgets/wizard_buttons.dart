import 'package:flutter/material.dart';
import 'package:recommendo/l10n/l10n.dart';

class GoForwardButton extends StatelessWidget {
  const GoForwardButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Text(context.l10n.continueButtonLabel),
      onPressed: onPressed,
      label: const Icon(Icons.arrow_forward),
    );
  }
}

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.arrow_back),
      onPressed: onPressed,
      label: Text(context.l10n.backButtonLabel),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Text(context.l10n.submitButtonLabel),
      onPressed: onPressed,
      label: const Icon(Icons.send),
    );
  }
}
