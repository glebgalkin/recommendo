import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecommendationsListLoading extends StatelessWidget {
  static const _tileHeight = 130.0;

  const RecommendationsListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const bodyWidget = ColoredBox(
      color: Colors.white,
    );

    const item = SizedBox(
      height: _tileHeight,
      child: bodyWidget,
    );

    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: item,
        );
      },
    );
  }
}
