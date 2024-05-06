import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.greyLaw,
).copyWith(
  inputDecorationTheme: _textFieldDecoration,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.greyLaw,
).copyWith(
  inputDecorationTheme: _textFieldDecoration,
  appBarTheme:
      const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
);

final _textFieldDecoration = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
