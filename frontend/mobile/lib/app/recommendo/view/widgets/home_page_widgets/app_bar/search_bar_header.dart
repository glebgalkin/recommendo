import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';

class SearchBarHeader extends StatelessWidget {
  const SearchBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsListBloc, RecommendationsListState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final searchState = context.read<SearchCubit>().state;
        final text = switch (state.status) {
          RecommendationsListStatus.loading => 'Loading',
          RecommendationsListStatus.success =>
            searchState.term.isEmpty ? 'Top recommendations' : searchState.term,
          RecommendationsListStatus.failure => 'smth went wrong',
          RecommendationsListStatus.invalidSearch => 'Oh shit, no city!',
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (searchState.cityResult != null)
              Text(
                searchState.cityResult!.preview,
                style: const TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            Text(
              text,
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
