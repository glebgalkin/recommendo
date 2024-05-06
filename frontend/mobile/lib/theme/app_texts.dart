import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
