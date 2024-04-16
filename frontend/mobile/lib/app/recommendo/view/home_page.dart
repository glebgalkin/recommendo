import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_openner.dart';
import 'package:recommendo/app/recommendo/view/widgets/recommendations_list.dart';
import 'package:recommendo/app/recommendo/view/widgets/search_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(),
          RecommendationsList(),
        ],
      ),
      floatingActionButton: CreatingPageOpenner(),
    );
  }
}
