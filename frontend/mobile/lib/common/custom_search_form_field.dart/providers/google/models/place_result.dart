import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class PlaceResult extends BaseSearchItem {
  const PlaceResult({
    required this.preview,
    required this.value,
  });

  @override
  final String preview;

  @override
  final String value;

  @override
  String? get previewImage => null;
}
