import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/common/geo_location/platform_geo_location.g.dart',
    kotlinOut:
        'android/app/src/main/kotlin/dev/flutter/pigeon_recommendo_geo_location/Messages.g.kt',
    swiftOut: 'ios/Runner/pigeon_recommendo_geo_location/Messages.g.swift',
    dartPackageName: 'pigeon_recommendo_geo_location',
  ),
)
class CoordinatesMessage {
  const CoordinatesMessage({required this.lat, required this.lng});
  final double lat;
  final double lng;
}

@HostApi()
abstract class PlatformGeoLocation {
  String getHostLanguage();

  @async
  CoordinatesMessage getCoordinates();
}
