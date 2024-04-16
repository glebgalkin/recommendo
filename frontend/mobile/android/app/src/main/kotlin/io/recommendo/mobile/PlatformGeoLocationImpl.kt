class PlatformGeoLocationImpl : PlatformGeoLocation {

  override fun getCoordinates(callback: (Result<CoordinatesMessage>) -> Unit) {

      callback(Result.success(CoordinatesMessage(12.1, 13.1)));
      // callback(Result.failure(FlutterError("code", "message", "details")))
  }
}