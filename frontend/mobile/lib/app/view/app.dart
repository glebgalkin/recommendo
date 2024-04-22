import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/creating_page_blocs/create_recommendation_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SearchCubit(getIt())),
        BlocProvider(create: (_) => CreateRecommendationCubit(getIt())),
        BlocProvider(
          create: (context) {
            final searchState = context.read<SearchCubit>().state;
            final initialStatus = searchState.cityResult == null
                ? RecommendationsListStatus.invalidSearch
                : RecommendationsListStatus.loading;
            final bloc = RecommendationsListBloc(getIt(), initialStatus);

            if (searchState.cityResult != null) {
              bloc.add(
                RecommendationsFetched(
                  cityResult: searchState.cityResult,
                  term: searchState.term,
                  rebuildWholeList: true,
                ),
              );
            }
            return bloc;
          },
        ),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
