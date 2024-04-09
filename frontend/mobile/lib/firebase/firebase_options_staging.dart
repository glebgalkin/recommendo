// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class FirebaseOptionsStaging {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => throw UnsupportedError(
          'FirebaseOptionsStaging have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.windows => throw UnsupportedError(
          'FirebaseOptionsStaging have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.linux => throw UnsupportedError(
          'FirebaseOptionsStaging have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        ),
      TargetPlatform.fuchsia => throw UnsupportedError(
          'FirebaseOptionsStaging have not been configured for fuchsia - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        )
    };
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5euVsw7cGi06tyBT5PpkGWqLgXvb4ytg',
    authDomain: 'recommendo-stg-dfg3.firebaseapp.com',
    projectId: 'recommendo-stg-dfg3',
    storageBucket: 'recommendo-stg-dfg3.appspot.com',
    messagingSenderId: '426874450368',
    appId: '1:426874450368:web:0c2e15c54ebab30f7dd825',
    measurementId: 'G-H8MPR143SD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVSkVN2myUJ-B23_pl2Sx4syZQNDAV4Lc',
    appId: '1:426874450368:android:babe50e82caeefd67dd825',
    messagingSenderId: '426874450368',
    projectId: 'recommendo-stg-dfg3',
    storageBucket: 'recommendo-stg-dfg3.appspot.com',
    androidClientId:
        '426874450368-n07o8gus1n397oap9ft97mc9cn24vf2v.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFfMnz0_PEvkFEolHwL5b8Qe6R0OkXQ9o',
    appId: '1:426874450368:ios:04e601127c0d0cb37dd82',
    messagingSenderId: '426874450368',
    projectId: 'recommendo-stg-dfg3',
    storageBucket: 'recommendo-stg-dfg3.appspot.com',
    iosClientId:
        '426874450368-p2iq5ofe35njfjvrv3bge4tbbvn1cu06.apps.googleusercontent.com',
    iosBundleId: 'io.recommendo.mobile.stg',
  );
}
