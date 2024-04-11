import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final lightTheme = FlexThemeData.light(scheme: FlexScheme.greyLaw).copyWith(
  inputDecorationTheme: _textFieldDecoration,
);

final darkTheme = FlexThemeData.dark(scheme: FlexScheme.greyLaw).copyWith(
  inputDecorationTheme: _textFieldDecoration,
);

final _textFieldDecoration = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
