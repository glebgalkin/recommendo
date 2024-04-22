import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

extension SnackBarExtensions on BuildContext {
  // Only for firebase exceptions
  void snackBarError(Exception exception) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(this).colorScheme.error,
        content: ErrorText(exception: exception),
        behavior: SnackBarBehavior.floating,
        width: 280,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );

  void snackBarErrorMsg(String errorMsg) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(this).colorScheme.error,
        content: Text(errorMsg),
        behavior: SnackBarBehavior.fixed,
      ),
    );
}
