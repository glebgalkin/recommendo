import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/google_auto_completion_search_result.dart';

class GoogleAutoCompletionRepository extends BaseSearchRepository {
  const GoogleAutoCompletionRepository(this._remote, this._types);

  final GoogleAutoCompletionRemote _remote;
  final String _types;

  @override
  Future<GoogleAutoCompletionSearchResult> search(String term) {
    try {
      return _remote.getPredictions(term, _types);
    } on DioException {
      throw const SearchResultError('Google is not available');
    }
  }
}

const autoCompleteCity = 'GoogleAutoCompleteCity';
