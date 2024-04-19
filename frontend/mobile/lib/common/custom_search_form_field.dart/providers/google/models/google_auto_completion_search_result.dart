import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

class GoogleAutoCompletionSearchResult extends BaseSearchResult {
  const GoogleAutoCompletionSearchResult({required this.items});

  @override
  final List<PlaceResult> items;
}
