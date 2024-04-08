import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Center(child: child),
        ],
      ),
    );
  }
}
