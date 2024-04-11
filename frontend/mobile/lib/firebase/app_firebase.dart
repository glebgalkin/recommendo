import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

class AppFirebase {
  static Future<void> initFirebase() async {
    final options = parseFirebaseOptions();
    await Firebase.initializeApp(options: options);
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      GoogleProvider(clientId: options.iosClientId ?? ''),
      AppleProvider(),
    ]);
  }

  static FirebaseOptions parseFirebaseOptions() {
    const configuration = String.fromEnvironment('FIREBASE_OPTIONS');
    final json = jsonDecode(configuration) as Map<String, dynamic>;

    return FirebaseOptions(
      apiKey: json['apiKey'] as String,
      appId: json['appId'] as String,
      messagingSenderId: json['messagingSenderId'] as String,
      projectId: json['projectId'] as String,
      authDomain: json['authDomain'] as String?,
      databaseURL: json['databaseURL'] as String?,
      storageBucket: json['storageBucket'] as String?,
      measurementId: json['measurementId'] as String?,
      trackingId: json['trackingId'] as String?,
      deepLinkURLScheme: json['deepLinkURLScheme'] as String?,
      androidClientId: json['androidClientId'] as String?,
      iosClientId: json['iosClientId'] as String?,
      iosBundleId: json['iosBundleId'] as String?,
      appGroupId: json['appGroupId'] as String?,
    );
  }
}
