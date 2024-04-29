import 'package:flutter/cupertino.dart';
import 'package:recommendo/l10n/l10n.dart';

class RecommendationsListBottomFailure extends StatelessWidget {
  const RecommendationsListBottomFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.l10n.failedFetchingRecommendationsMsg),
    );
  }
}
