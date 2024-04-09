import 'package:flutter/material.dart';

class MoveForwardButton extends StatelessWidget {
  const MoveForwardButton({
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

class MoveBackButton extends StatelessWidget {
  const MoveBackButton({
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
