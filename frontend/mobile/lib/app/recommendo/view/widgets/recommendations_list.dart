import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/search_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/bottom_loader.dart';
import 'package:recommendo/app/recommendo/view/widgets/recommendations_list_item.dart';
import 'package:recommendo/l10n/l10n.dart';

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
          return SliverList.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 32),
            itemCount: state.recommendations.length + 1,
            itemBuilder: (context, index) {
              if (state.status == RecommendationsListStatus.initial) {
                return const CupertinoActivityIndicator();
              }
              if (state.status == RecommendationsListStatus.invalidSearch) {
                return Center(
                  child: Text(context.l10n.invalidSearchMsg),
                );
              }
              if (state.recommendations.isEmpty) {
                return Center(
                  child: Text(context.l10n.emptyRecommendationList),
                );
              }

              return index >= state.recommendations.length
                  ? _buildLastItem(context, state)
                  : RecommendationsListItem(
                      recommendation: state.recommendations[index],
                    );
            },
          );
        },
      ),
    );
  }

  Widget _buildLastItem(BuildContext context, RecommendationsListState state) {
    if (state.hasReachedMax) {
      return const SizedBox.shrink();
    }
    if (state.status == RecommendationsListStatus.failure) {
      return Center(child: Text(context.l10n.failedFetchingRecommendationsMsg));
    }
    return const BottomLoader();
  }
}
