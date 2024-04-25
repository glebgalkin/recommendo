import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.greyLaw,
).copyWith(
  inputDecorationTheme: _textFieldDecoration,
  elevatedButtonTheme: _elevatedButtonStyle,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.greyLaw,
).copyWith(
  inputDecorationTheme: _textFieldDecoration,
  elevatedButtonTheme: _elevatedButtonStyle,
  appBarTheme:
      const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
);

final _textFieldDecoration = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

final _elevatedButtonStyle = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  ),
);
