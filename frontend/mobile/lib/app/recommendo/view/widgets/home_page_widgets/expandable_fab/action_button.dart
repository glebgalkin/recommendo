import 'package:flutter/material.dart';

class FabActionButton extends StatelessWidget {
  const FabActionButton({
    required this.onTap,
    required this.child,
    required this.backgroundColor,
    required this.heroTag,
    super.key,
  });

  final VoidCallback onTap;
  final Widget child;
  final Color backgroundColor;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onTap,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
