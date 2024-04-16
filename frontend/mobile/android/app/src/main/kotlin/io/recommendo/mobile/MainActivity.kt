package io.recommendo.mobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import PlatformGeoLocationImpl

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        PlatformGeoLocation.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            PlatformGeoLocationImpl(),
        );
    }
}
