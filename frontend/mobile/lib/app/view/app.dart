import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/connection_cubit.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/home_page_blocs/search_cubit.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/navigation/app_router.dart';
import 'package:recommendo/service_locator/service_locator.dart';
import 'package:recommendo/theme/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppConnectionCubit()),
        BlocProvider(create: (_) => SearchCubit(getIt())),
        BlocProvider(create: (_) => CreateRecommendationCubit(getIt())),
        BlocProvider(
          create: (context) {
            final searchState = context.read<SearchCubit>().state;
            final initialStatus = searchState.cityResult == null
                ? RecommendationsListStatus.invalidSearch
                : RecommendationsListStatus.loading;
            final bloc = RecommendationsListBloc(getIt(), initialStatus);

            return bloc;
          },
        ),
      ],
      child: BlocListener<AppConnectionCubit, AppConnectionState>(
        listenWhen: (previous, current) =>
            previous == AppConnectionState.initialState,
        listener: (context, state) {
          final searchState = context.read<SearchCubit>().state;
          final listBloc = context.read<RecommendationsListBloc>();
          if (searchState.cityResult != null) {
            final offlineSearch = context.read<AppConnectionCubit>().isOffline;
            listBloc.add(
              RecommendationsFetched(
                cityResult: searchState.cityResult,
                term: searchState.term,
                showLoader: true,
                searchOnDevice: offlineSearch,
              ),
            );
          }
        },
        child: BlocListener<AppConnectionCubit, AppConnectionState>(
          listenWhen: (previous, current) =>
              previous == AppConnectionState.connectionOff &&
              current == AppConnectionState.connectionOn,
          listener: (context, state) {
            final searchState = context.read<SearchCubit>().state;
            final listBloc = context.read<RecommendationsListBloc>();
            if (listBloc.state.status == RecommendationsListStatus.success &&
                listBloc.state.recommendations.isEmpty) {
              listBloc.add(
                RecommendationsFetched(
                  cityResult: searchState.cityResult,
                  term: searchState.term,
                  showLoader: true,
                ),
              );
            }
          },
          child: app,
        ),
      ),
    );
  }
}
