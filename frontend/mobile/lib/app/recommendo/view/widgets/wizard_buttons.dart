import 'package:flutter/material.dart';

class GoForwardButton extends StatelessWidget {
  const GoForwardButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Text('Continue'),
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
      label: const Text('Back'),
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
      icon: const Text('Submit'),
      onPressed: onPressed,
      label: const Icon(Icons.send),
    );
  }
}
