import 'package:equatable/equatable.dart';

abstract class BaseSearchItem implements Equatable {
  const BaseSearchItem();

  String get preview;
  String get value;
  String? get previewImage;
}
