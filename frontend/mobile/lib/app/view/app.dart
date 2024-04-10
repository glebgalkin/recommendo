import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/navigation/app_router.dart';
import 'package:recommendo/recommendo/view/bloc/stepper_bloc.dart';
import 'package:recommendo/service_locator/service_locator.dart';
import 'package:recommendo/theme/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StepperBloc(getIt()),
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
