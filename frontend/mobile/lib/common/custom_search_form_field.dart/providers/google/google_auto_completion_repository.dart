import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_item.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_last_selected.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/google_auto_completion_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/google_auto_completion_search_result.dart';

class GoogleAutoCompletionRepository extends BaseSearchRepository {
  const GoogleAutoCompletionRepository(
    this._remote,
    this._types,
    this._lastSelected,
  );

  final GoogleAutoCompletionRemote _remote;
  final String _types;
  final GoogleAutoCompletionLastSelected _lastSelected;

  @override
  Future<GoogleAutoCompletionSearchResult> search(String term) {
    try {
      return _remote.getPredictions(term, _types);
    } on DioException {
      throw const SearchResultError('Google is not available');
    }
  }

  @override
  GoogleAutoCompletionSearchResult previousSearchResult() {
    return GoogleAutoCompletionSearchResult(
      items: _lastSelected.getLastSelected(),
    );
  }

  @override
  Future<void> saveSelected(BaseSearchItem item) async {
    return _lastSelected.saveSelected(item as PlaceResult);
  }
}

const autoCompleteCity = 'GoogleAutoCompleteCity';
const autoCompleteEstablishment = 'GoogleAutoCompleteEstablishment';
