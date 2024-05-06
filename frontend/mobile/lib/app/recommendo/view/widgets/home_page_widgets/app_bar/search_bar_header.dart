import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/l10n/l10n.dart';

class SearchBarHeader extends StatelessWidget {
  const SearchBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsListBloc, RecommendationsListState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final searchState = context.read<SearchCubit>().state;
        final l10n = context.l10n;
        final text = switch (state.status) {
          RecommendationsListStatus.loading => l10n.searchAppBarLoading,
          RecommendationsListStatus.success => searchState.term.isEmpty
              ? l10n.searchAppBarDefaultTitle
              : searchState.term,
          RecommendationsListStatus.failure => l10n.searchAppBarErrorMsg,
          RecommendationsListStatus.invalidSearch =>
            l10n.searchAppBarInvalisSearch,
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
