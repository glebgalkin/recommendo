import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result_error.dart';

class GoogleMapsSearchResultError extends BaseSearchResultError {
  const GoogleMapsSearchResultError({required this.message});

  @override
  final String message;
}
