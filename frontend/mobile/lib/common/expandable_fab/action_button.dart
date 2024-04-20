import 'package:flutter/material.dart';

class FabActionButton extends StatelessWidget {
  const FabActionButton({
    required this.onTap,
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
