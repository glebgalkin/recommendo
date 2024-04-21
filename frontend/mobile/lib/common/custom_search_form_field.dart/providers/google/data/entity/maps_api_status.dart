import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum MapsApiStatus {
  ok,
  zeroResults,
  invalidRequest,
  overQueryLimit,
  requestDenied,
  unknownError
}
