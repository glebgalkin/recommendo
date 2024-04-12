import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class CityResult extends BaseSearchItem {
  const CityResult({
    required this.preview,
    required this.value,
  });

  factory CityResult.fromJson(Map<String, dynamic> json) {
    return CityResult(
      preview: json['description'] as String,
      value: json['place_id'] as String,
    );
  }
  @override
  final String preview;

  @override
  final String value;

  @override
  String? get previewImage => null;
}
