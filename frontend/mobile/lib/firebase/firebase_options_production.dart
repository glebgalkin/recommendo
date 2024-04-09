// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class FirebaseOptionsProduction {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => throw UnsupportedError(
          'FirebaseOptionsProduction have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.windows => throw UnsupportedError(
          'FirebaseOptionsProduction have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.linux => throw UnsupportedError(
          'FirebaseOptionsProduction have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.fuchsia => throw UnsupportedError(
          'FirebaseOptionsProduction have not been configured for fuchsia - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        )
    };
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCELgPNjrycd5pDqsXyDi74G3eo2pgtnuQ',
    appId: '1:101976121662:web:384706d7ce4b8a185e4c6f',
    messagingSenderId: '101976121662',
    projectId: 'recommendo-prd-a3gd',
    authDomain: 'recommendo-prd-a3gd.firebaseapp.com',
    storageBucket: 'recommendo-prd-a3gd.appspot.com',
    measurementId: 'G-WXJWHE8SDM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFiDUYlNa_USpcsgOdzZI9YQCRAErTSm0',
    appId: '1:101976121662:android:df827f6442be6a425e4c6f',
    messagingSenderId: '101976121662',
    projectId: 'recommendo-prd-a3gd',
    storageBucket: 'recommendo-prd-a3gd.appspot.com',
    androidClientId:
        '101976121662-seckloot712r211hb9asqpjdtal2r2bb.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfaE-69mQ2QqWqIMWDsvLcH7AZvk6LSE0',
    appId: '1:101976121662:ios:c986246feaf754c55e4c6f',
    messagingSenderId: '101976121662',
    projectId: 'recommendo-prd-a3gd',
    storageBucket: 'recommendo-prd-a3gd.appspot.com',
    iosClientId:
        '101976121662-v5vonqefgn62d4ifcf89bdvb48b7dv3n.apps.googleusercontent.com',
    iosBundleId: 'io.recommendo.mobile',
  );
}
