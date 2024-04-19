import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/common/geo_location/platform_geo_location.g.dart',
    kotlinOut: 'android/app/src/main/kotlin/io/recommendo/mobile/Messages.g.kt',
    swiftOut: 'ios/Runner/Messages.g.swift',
    dartPackageName: 'pigeon_recommendo_geo_location',
  ),
)
class CoordinatesMessage {
  const CoordinatesMessage({required this.lat, required this.lng});
  final double lat;
  final double lng;
}

@HostApi()
// ignore: one_member_abstracts
abstract class PlatformGeoLocation {
  @async
  CoordinatesMessage getCoordinates();
}
