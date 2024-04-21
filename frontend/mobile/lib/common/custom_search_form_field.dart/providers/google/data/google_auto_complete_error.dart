class GoogleAutoCompleteError implements Exception {
  final AutoCompleteErrorCode code;

  const GoogleAutoCompleteError._(this.code);

  const GoogleAutoCompleteError.invalidRequest()
      : this._(AutoCompleteErrorCode.invalidRequest);

  const GoogleAutoCompleteError.overQueryLimit()
      : this._(AutoCompleteErrorCode.overQueryLimit);

  const GoogleAutoCompleteError.requestDenied()
      : this._(AutoCompleteErrorCode.requestDenied);

  const GoogleAutoCompleteError.googleUnknown()
      : this._(AutoCompleteErrorCode.googleUnknown);
}

enum AutoCompleteErrorCode {
  invalidRequest,
  overQueryLimit,
  requestDenied,
  googleUnknown,
}
