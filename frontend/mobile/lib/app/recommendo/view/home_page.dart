import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/creating_page_openner.dart';
import 'package:recommendo/app/recommendo/view/widgets/recommendations_list.dart';
import 'package:recommendo/common/custom_search_form_field.dart/city_search_form_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            stretch: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(130),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SearchCityFormField(
                      onSaved: (_) {},
                      validator: (_) {
                        return 'null';
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        label: const Text('Term'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const RecommendationsList(),
        ],
      ),
      floatingActionButton: const CreatingPageOpenner(),
    );
  }
}
