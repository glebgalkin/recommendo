import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/create_recommendation_cubit.dart';
import 'package:recommendo/app/recommendo/view/bloc/recommendations_list_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/search_cubit.dart';
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
        BlocProvider<RecommendationsListBloc>(
          create: (context) => RecommendationsListBloc(getIt())
            ..add(const RecommendationsFetched()),
        ),
        BlocProvider<CreateRecommendationCubit>(
          create: (context) => CreateRecommendationCubit(getIt()),
        ),
        BlocProvider(create: (context) => SearchCubit()),
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
