import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_widgets/creating_page_openner.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/recommendations_list.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/search_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const CustomScrollView(
            slivers: [
              SearchAppBar(),
              RecommendationsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: const CreatingPageOpenner(),
    );
  }
}
