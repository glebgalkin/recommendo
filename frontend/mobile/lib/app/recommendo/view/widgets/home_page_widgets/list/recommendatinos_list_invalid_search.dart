import 'package:flutter/material.dart';
import 'package:recommendo/l10n/l10n.dart';

class RecommendationsListInvalidSearch extends StatelessWidget {
  const RecommendationsListInvalidSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        title: Text(context.l10n.invalidSearchMsg),
      ),
    );
  }
}
