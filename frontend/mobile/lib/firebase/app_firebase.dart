import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:minimal_advertisment/firebase/firebase_options_development.dart';
import 'package:minimal_advertisment/firebase/firebase_options_production.dart';
import 'package:minimal_advertisment/firebase/firebase_options_staging.dart';

class AppFirebase {
  static Future<void> initFirebase(String? flavour) async {
    if (flavour == null) {
      throw UnsupportedError('Flavour mast be provided');
    }
    final currentOptions = _currentOptions(flavour);

    await Firebase.initializeApp(options: currentOptions);

    if (TargetPlatform.iOS == defaultTargetPlatform) {
      FirebaseUIAuth.configureProviders([
        // think about email auth providers
        EmailAuthProvider(),
        GoogleProvider(clientId: currentOptions.iosClientId!),
        AppleProvider(),
      ]);
    } else if (TargetPlatform.android == defaultTargetPlatform) {
      FirebaseUIAuth.configureProviders([
        EmailAuthProvider(),
        GoogleProvider(
          clientId: currentOptions.androidClientId!,
        ),
        AppleProvider(),
      ]);
    }
  }

  static FirebaseOptions _currentOptions(String flavour) {
    return switch (flavour) {
      'development' => FirebaseOptionsDevelopment.currentPlatform,
      'staging' => FirebaseOptionsStaging.currentPlatform,
      'production' => FirebaseOptionsProduction.currentPlatform,
      _ => throw UnsupportedError('Flavour mast be provided'),
    };
  }
}
