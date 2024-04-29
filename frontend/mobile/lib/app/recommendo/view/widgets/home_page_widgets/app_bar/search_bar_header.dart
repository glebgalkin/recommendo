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
        // TODO(Konyaka1): Add localizations
        final text = switch (state.status) {
          RecommendationsListStatus.loading => 'Loading',
          RecommendationsListStatus.success =>
            searchState.term.isEmpty ? 'Top recommendations' : searchState.term,
          RecommendationsListStatus.failure => 'smth went wrong',
          RecommendationsListStatus.invalidSearch => 'Oh shit, no city!',
        };

        return Column(
          children: [
            if (searchState.cityResult != null)
              Text(
                searchState.cityResult!.preview,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 8),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
