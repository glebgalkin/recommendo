import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/local_place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/place_autocomplete_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/local/google_auto_completion_last_selected.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/remote/google_auto_completion_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/google_auto_complete_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/google_auto_completion_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

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
  Future<GoogleAutoCompletionSearchResult> search(String term) async {
    try {
      final response = await _remote.getPredictions(term, _types);

      switch (response.status) {
        case AutoompleteStatus.ok:
          final list = response.predictions
              .map(
                (e) => PlaceResult(preview: e.description, value: e.placeId),
              )
              .toList();
          return GoogleAutoCompletionSearchResult(items: list);
        case AutoompleteStatus.zeroResults:
          return const GoogleAutoCompletionSearchResult(items: []);
        case AutoompleteStatus.invalidRequest:
          throw const GoogleAutoCompleteError(invalidRequest);
        case AutoompleteStatus.overQueryLimit:
          throw const GoogleAutoCompleteError(overQueryLimit);
        case AutoompleteStatus.requestDenied:
          throw const GoogleAutoCompleteError(requestDenied);
        case AutoompleteStatus.unknownError:
          throw const GoogleAutoCompleteError(googleUnknown);
      }
    } on DioException {
      throw const GoogleAutoCompleteError(networkError);
    } on Exception {
      throw const GoogleAutoCompleteError(unknown);
    }
  }

  @override
  GoogleAutoCompletionSearchResult previousSearchResult() {
    return GoogleAutoCompletionSearchResult(
      items: _lastSelected
          .getLastSelected()
          .map((e) => PlaceResult(preview: e.preview, value: e.value))
          .toList(),
    );
  }

  @override
  Future<void> saveSelected(covariant PlaceResult item) {
    final localPlaceResult = LocalPlaceResult(
      preview: item.preview,
      value: item.value,
      timeSelected: DateTime.now(),
    );
    return _lastSelected.saveSelected(localPlaceResult);
  }
}

const autoCompleteCity = 'GoogleAutoCompleteCity';
const autoCompleteEstablishment = 'GoogleAutoCompleteEstablishment';
