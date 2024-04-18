import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

class GoogleAutoCompletionSearchResult extends BaseSearchResult {
  const GoogleAutoCompletionSearchResult({required this.items});

  factory GoogleAutoCompletionSearchResult.fromJson(Map<String, dynamic> json) {
    final items = (json['predictions'] as List<dynamic>)
        .map(
          (dynamic item) => PlaceResult.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return GoogleAutoCompletionSearchResult(items: items);
  }

  @override
  final List<PlaceResult> items;
}
