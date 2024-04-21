import 'package:flutter/cupertino.dart';

class RecommendationsListLoading extends StatelessWidget {
  const RecommendationsListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: CupertinoActivityIndicator());
  }
}
