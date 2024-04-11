import 'package:recommendo/common/custom_search_form_field.dart/internal/base_search_result_error.dart';

class GithubSearchResultError extends BaseSearchResultError {
  GithubSearchResultError({required this.message});

  factory GithubSearchResultError.fromJson(Map<String, dynamic> json) {
    return GithubSearchResultError(
      message: json['message'] as String,
    );
  }

  @override
  final String message;
}
