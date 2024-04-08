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
    apiKey: 'AIzaSyAuytLbnBXyoENO05MwE83eJhgvzcB6r7Q',
    appId: '1:9762032304:web:3d12712f229b0bbae58975',
    messagingSenderId: '9762032304',
    projectId: 'minimal-advertisement-stg-1s44',
    authDomain: 'minimal-advertisement-stg-1s44.firebaseapp.com',
    storageBucket: 'minimal-advertisement-stg-1s44.appspot.com',
    measurementId: 'G-H2P06DWGNE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCM7q6q0iZiXIGzirs1mCoa1_ZUmpGf3fE',
    appId: '1:9762032304:android:3e8e56bc5f76fe9de58975',
    messagingSenderId: '9762032304',
    projectId: 'minimal-advertisement-stg-1s44',
    storageBucket: 'minimal-advertisement-stg-1s44.appspot.com',
    androidClientId:
        '9762032304-9a7pjvqbs9fm93m5lhged7qg2gth6up8.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcTaAnz7ksOZ3PHC1ZY0uGqFSdSgzDiQs',
    appId: '1:9762032304:ios:c411b3561ea93032e58975',
    messagingSenderId: '9762032304',
    projectId: 'minimal-advertisement-stg-1s44',
    storageBucket: 'minimal-advertisement-stg-1s44.appspot.com',
    iosClientId:
        '9762032304-31gffi09ll1mn30ha9rplis2tlk6i4ra.apps.googleusercontent.com',
    iosBundleId: 'io.recommendo.mobile.stg',
  );
}
