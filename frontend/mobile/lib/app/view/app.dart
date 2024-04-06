import 'package:flutter/material.dart';
import 'package:minimal_advertisment/l10n/l10n.dart';
import 'package:minimal_advertisment/navigation/app_router.dart';
import 'package:minimal_advertisment/theme/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
