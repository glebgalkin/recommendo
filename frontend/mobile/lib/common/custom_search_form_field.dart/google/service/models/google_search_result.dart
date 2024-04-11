import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_result_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';

class GoogleMapsSearchResult extends BaseSearchResult {
  const GoogleMapsSearchResult({required this.items});

  factory GoogleMapsSearchResult.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .take(5)
        .map(
          (dynamic item) =>
              GoogleMapsSearchResultItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return GoogleMapsSearchResult(items: items);
  }

  @override
  final List<GoogleMapsSearchResultItem> items;
}
