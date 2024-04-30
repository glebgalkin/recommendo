import 'package:flutter/material.dart';

class SearchFieldDefaultError extends StatelessWidget {
  const SearchFieldDefaultError({required this.error, super.key});

  final String error;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(error),
    );
  }
}
