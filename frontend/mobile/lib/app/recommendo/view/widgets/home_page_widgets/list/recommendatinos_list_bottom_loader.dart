import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';

class RecommendationsListBottomLoader extends StatefulWidget {
  const RecommendationsListBottomLoader({super.key});

  @override
  State<RecommendationsListBottomLoader> createState() =>
      _RecommendationsListBottomLoaderState();
}

class _RecommendationsListBottomLoaderState
    extends State<RecommendationsListBottomLoader> {
  @override
  void initState() {
    super.initState();
    final state = context.read<SearchCubit>().state;
    context.read<RecommendationsListBloc>().add(
          RecommendationsFetched(
            cityResult: state.cityResult,
            term: state.term,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
