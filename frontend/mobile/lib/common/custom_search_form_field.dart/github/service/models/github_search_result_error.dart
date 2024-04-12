import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result_error.dart';

class GithubSearchResultError extends BaseSearchResultError {
  const GithubSearchResultError({required this.message});

  @override
  final String message;
}
