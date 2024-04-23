import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_bar/search_bar_form.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_bar/search_bar_header.dart';

class SearchFlexibleSpace extends StatelessWidget {
  const SearchFlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = max(0, 1.0 - kToolbarHeight / deltaExtent).toDouble();
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            // collapsed
            Opacity(
              opacity: 1 - opacity,
              child: const SearchBarHeader(),
            ),
            // expanded
            Opacity(
              opacity: opacity,
              child: const SearchBarForm(),
            ),
          ],
        );
      },
    );
  }
}
