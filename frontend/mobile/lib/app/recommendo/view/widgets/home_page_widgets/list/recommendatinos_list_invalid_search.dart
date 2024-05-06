import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/l10n/l10n.dart';

class RecommendationsListInvalidSearch extends StatelessWidget {
  const RecommendationsListInvalidSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(context.l10n.invalidSearchMsg),
          ),
          TextButton.icon(
            onPressed: () => context.read<SearchCubit>().getCityByGeoLocation(),
            label: const Icon(Icons.location_searching),
            icon: Text(context.l10n.getCurrentLocation),
          ),
        ],
      ),
    );
  }
}
