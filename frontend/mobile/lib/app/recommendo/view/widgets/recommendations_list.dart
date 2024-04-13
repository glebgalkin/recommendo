import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/widgets/bottom_loader.dart';
import 'package:recommendo/app/recommendo/view/widgets/recommendations_list_item.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsListBloc, RecommendationsListState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.recommendations.length + 1,
            (context, index) {
              if (state.status == RecommendationsListStatus.failure) {
                return const Center(
                  child: Text('failed to fetch recommendations'),
                );
              }
              if (state.status == RecommendationsListStatus.initial) {
                return const CupertinoActivityIndicator();
              }
              if (state.recommendations.isEmpty) {
                return const Center(child: Text('no recommendations'));
              }

              return index >= state.recommendations.length
                  ? const BottomLoader()
                  : RecommendationsListItem(
                      recommendation: state.recommendations[index],
                    );
            },
          ),
        );
      },
    );
  }
}
