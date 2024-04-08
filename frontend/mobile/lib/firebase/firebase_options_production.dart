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
    apiKey: 'AIzaSyCeWekwXuE4r6bKUkrlE9auEYNX1n33D4A',
    appId: '1:939041077818:web:db738edf11a28736a1d303',
    messagingSenderId: '939041077818',
    projectId: 'minimal-advertisement-prd-2d65',
    authDomain: 'minimal-advertisement-prd-2d65.firebaseapp.com',
    storageBucket: 'minimal-advertisement-prd-2d65.appspot.com',
    measurementId: 'G-BW3904CQHT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQwyUGtg4rGlfgG7nhFwvR7gOMg0wIBnc',
    appId: '1:939041077818:android:5dbb65bd3344432fa1d303',
    messagingSenderId: '939041077818',
    projectId: 'minimal-advertisement-prd-2d65',
    storageBucket: 'minimal-advertisement-prd-2d65.appspot.com',
    androidClientId:
        '939041077818-e0pih5tdkck6ptp54s59p0sjt7lisdpo.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhD38shsjRXvw76RyRcv8AZYJTXi5mHHs',
    appId: '1:939041077818:ios:3fd3648343dacdaaa1d303',
    messagingSenderId: '939041077818',
    projectId: 'minimal-advertisement-prd-2d65',
    storageBucket: 'minimal-advertisement-prd-2d65.appspot.com',
    iosClientId:
        '939041077818-jffie113rs6cko1a79uqau05a7df4dlt.apps.googleusercontent.com',
    iosBundleId: 'io.recommendo.mobile',
  );
}
