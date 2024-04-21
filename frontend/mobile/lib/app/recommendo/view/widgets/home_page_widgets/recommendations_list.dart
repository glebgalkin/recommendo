import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/list/recommendatinos_list_bottom_loader.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/list/recommendatinos_list_bottom_failure.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/list/recommendatinos_list_empty_message.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/list/recommendatinos_list_invalid_search.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/list/recommendatinos_list_loading.dart';
import 'package:recommendo/app/recommendo/view/widgets/home_page_widgets/list/recommendations_list_item.dart';

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
                rebuildWholeList: true,
              ),
            );
      },
      child: BlocBuilder<RecommendationsListBloc, RecommendationsListState>(
        builder: (context, state) {
          if (state.status == RecommendationsListStatus.loading) {
            return const RecommendationsListLoading();
          }
          if (state.status == RecommendationsListStatus.invalidSearch) {
            return const RecommendationsListInvalidSearch();
          }
          if (state.status == RecommendationsListStatus.success &&
              state.recommendations.isEmpty) {
            return const RecommendationsListEmptyMessage();
          }
          return SliverList.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 32),
            itemCount: state.recommendations.length + 1,
            itemBuilder: (context, index) {
              if (index == state.recommendations.length) {
                return _buildLastItem(context, state);
              }

              return RecommendationsListItem(
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
      return const RecommendationsListBottomFailure();
    }
    return const RecommendationsListBottomLoader();
  }
}
