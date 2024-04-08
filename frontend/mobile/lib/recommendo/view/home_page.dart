import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/view/widgets/creating_page_openner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: CreatingPageOpenner(),
    );
  }
}
