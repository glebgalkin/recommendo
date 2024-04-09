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
    apiKey: 'AIzaSyA5IHRVfe-Yg4HgwZRuFOeRWPscbnzdi_k',
    appId: '1:908321911232:web:84d16ff42dfc5f295f9825',
    messagingSenderId: '908321911232',
    projectId: 'recommendo-dev-er3r',
    authDomain: 'recommendo-dev-er3r.firebaseapp.com',
    storageBucket: 'recommendo-dev-er3r.appspot.com',
    measurementId: 'G-F6KECPE157',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPWGayzsar2274OtZfGlzMWNs4hWgcruA',
    appId: '1:908321911232:android:6fa1bf872b3a51685f9825',
    messagingSenderId: '908321911232',
    projectId: 'recommendo-dev-er3r',
    storageBucket: 'recommendo-dev-er3r.appspot.com',
    androidClientId:
        '908321911232-4428m49i48ubhlvpa47p9241mukkjp03.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGsPgHI--_NyCT0XF2F4kQ39dIJEKQ4OM',
    appId: '1:908321911232:ios:0617a060887ad25b5f9825',
    messagingSenderId: '1064556328438',
    projectId: 'recommendo-dev-er3r',
    storageBucket: 'recommendo-dev-er3r.appspot.com',
    iosClientId:
        '908321911232-86706duv43j8dcjsilbv45u93u66oi88.apps.googleusercontent.com',
    iosBundleId: 'io.recommendo.mobile.dev',
  );
}
