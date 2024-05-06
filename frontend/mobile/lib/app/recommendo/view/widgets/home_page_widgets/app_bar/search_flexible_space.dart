import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_bar/search_bar_form.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/app_bar/search_bar_header.dart';

class SearchFlexibleSpace extends StatefulWidget {
  const SearchFlexibleSpace({super.key});

  @override
  State<SearchFlexibleSpace> createState() => _SearchFlexibleSpaceState();
}

class _SearchFlexibleSpaceState extends State<SearchFlexibleSpace> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: '_termFieldFocus');
  }

  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    final deltaExtent = settings.maxExtent - settings.minExtent;
    return -Tween<double>(begin: 0, end: deltaExtent / 4.0).transform(t);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = max(0, 1.0 - kToolbarHeight / deltaExtent).toDouble();
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        // opacity == 0 == collapsed
        // opacity == 1 == expanded
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (opacity != 1) {
              _focusNode.requestFocus();
            }
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // collapsed
              Opacity(
                opacity: 1 - opacity,
                child: const SearchBarHeader(),
              ),
              // expanded
              Positioned(
                top: _getCollapsePadding(t, settings),
                left: 0,
                right: 0,
                child: AbsorbPointer(
                  absorbing: opacity != 1,
                  child: Opacity(
                    opacity: opacity,
                    child: SearchBarForm(termFieldFocus: _focusNode),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
