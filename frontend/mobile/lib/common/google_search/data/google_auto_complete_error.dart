class GoogleMapsApiError implements Exception {
  final MapsApiErrorCode code;

  const GoogleMapsApiError._(this.code);

  const GoogleMapsApiError.invalidRequest()
      : this._(MapsApiErrorCode.invalidRequest);

  const GoogleMapsApiError.overQueryLimit()
      : this._(MapsApiErrorCode.overQueryLimit);

  const GoogleMapsApiError.requestDenied()
      : this._(MapsApiErrorCode.requestDenied);

  const GoogleMapsApiError.googleUnknown()
      : this._(MapsApiErrorCode.googleUnknown);
}

enum MapsApiErrorCode {
  invalidRequest,
  overQueryLimit,
  requestDenied,
  googleUnknown,
}
