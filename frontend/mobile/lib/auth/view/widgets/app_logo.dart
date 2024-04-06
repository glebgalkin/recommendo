import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          FlareActor(
            'assets/flares/circle.flr',
            animation: 'Alarm',
            color: Theme.of(context).highlightColor,
          ),
          const FlutterLogo(
            size: 64,
          ),
        ],
      ),
    );
  }
}
