import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/search_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/bottom_loader.dart';
import 'package:recommendo/app/recommendo/view/widgets/recommendations_list_item.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        context.read<RecommendationsListBloc>().add(
              RecommendationsFetched(
                cityResult: state.cityResult,
                term: state.term,
                refresh: true,
              ),
            );
      },
      child: BlocBuilder<RecommendationsListBloc, RecommendationsListState>(
        builder: (context, state) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.recommendations.length + 1,
              (context, index) {
                if (state.status == RecommendationsListStatus.initial) {
                  return const CupertinoActivityIndicator();
                }
                if (state.status == RecommendationsListStatus.invalidSearch) {
                  return const Center(
                    child: Text('Invalid search. City is required'),
                  );
                }
                if (state.recommendations.isEmpty) {
                  return const Center(child: Text('no recommendations'));
                }

                return index >= state.recommendations.length
                    ? _buildLastItem(state)
                    : RecommendationsListItem(
                        recommendation: state.recommendations[index],
                      );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLastItem(RecommendationsListState state) {
    if (state.hasReachedMax) {
      return const SizedBox.shrink();
    }
    if (state.status == RecommendationsListStatus.failure) {
      return const Center(child: Text('Failed to fetch'));
    }
    return const BottomLoader();
  }
}
