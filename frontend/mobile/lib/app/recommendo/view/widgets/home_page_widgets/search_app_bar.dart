import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_bar/search_flexible_space.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4,
      pinned: true,
      snap: true,
      floating: true,
      // TODO(Konyaka1): not sure it's the best tactic here
      collapsedHeight: 60,
      expandedHeight: 155,
      flexibleSpace: const SearchFlexibleSpace(),
    );
  }
}
