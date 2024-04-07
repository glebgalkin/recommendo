import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:recommendo/recommendo/creating_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _fab = 56.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: OpenContainer<String?>(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (context, closeContainer) => CreatingWizardPage(
          closeContainer: closeContainer,
        ),
        transitionDuration: Durations.extralong1,
        onClosed: print,
        useRootNavigator: true,
        closedElevation: 6,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fab / 2),
          ),
        ),
        closedColor: Theme.of(context).primaryColor,
        //tappable: false,
        closedBuilder: (context, openContainer) => SizedBox.square(
          dimension: _fab,
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
