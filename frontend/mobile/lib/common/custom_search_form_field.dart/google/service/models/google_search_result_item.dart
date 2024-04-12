import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';

class GoogleMapsSearchResultItem extends BaseSearchItem {
  const GoogleMapsSearchResultItem({
    required this.preview,
    required this.value,
  });

  factory GoogleMapsSearchResultItem.fromJson(Map<String, dynamic> json) {
    return GoogleMapsSearchResultItem(
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
