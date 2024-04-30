import 'package:recommendo/common/localized_error_text.dart';

class SearchResultError implements Exception {
  const SearchResultError(this.code);
  final LocalizedErrorMessage code;
}
