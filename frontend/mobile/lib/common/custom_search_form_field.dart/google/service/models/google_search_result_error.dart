import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result_error.dart';

class GoogleMapsSearchResultError extends BaseSearchResultError {
  GoogleMapsSearchResultError({required this.message});

  factory GoogleMapsSearchResultError.fromJson(Map<String, dynamic> json) {
    return GoogleMapsSearchResultError(
      message: json['message'] as String,
    );
  }

  @override
  final String message;
}
