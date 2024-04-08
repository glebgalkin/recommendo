// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class FirebaseOptionsDevelopment {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => throw UnsupportedError(
          'FirebaseOptionsDevelopment have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.windows => throw UnsupportedError(
          'FirebaseOptionsDevelopment have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.linux => throw UnsupportedError(
          'FirebaseOptionsDevelopment have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.fuchsia => throw UnsupportedError(
          'FirebaseOptionsDevelopment have not been configured for fuchsia - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        )
    };
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCLbGvogcMj2fzdQ3pD3wW-NvXLmFSTtNI',
    appId: '1:1064556328438:web:abc8f92831b168380b43d7',
    messagingSenderId: '1064556328438',
    projectId: 'minimal-advertisement-dev-aed1',
    authDomain: 'minimal-advertisement-dev-aed1.firebaseapp.com',
    storageBucket: 'minimal-advertisement-dev-aed1.appspot.com',
    measurementId: 'G-F1L6FXY4V6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzPEsE3IlJHkONte9KVfZ02jOOFLPdfqQ',
    appId: '1:1064556328438:android:cb77e41f44b720ed0b43d7',
    messagingSenderId: '1064556328438',
    projectId: 'minimal-advertisement-dev-aed1',
    storageBucket: 'minimal-advertisement-dev-aed1.appspot.com',
    androidClientId:
        '9762032304-9a7pjvqbs9fm93m5lhged7qg2gth6up8.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9e4MCQNfLUQeBN4WDhKfBCS5aLyrylsw',
    appId: '1:1064556328438:ios:047fff975fdcbb1c0b43d7',
    messagingSenderId: '1064556328438',
    projectId: 'minimal-advertisement-dev-aed1',
    storageBucket: 'minimal-advertisement-dev-aed1.appspot.com',
    iosClientId:
        '1064556328438-vtca1c1i0mkf7h2am1k6ln8g44lofqam.apps.googleusercontent.com',
    iosBundleId: 'io.recommendo.mobile.dev',
  );
}
