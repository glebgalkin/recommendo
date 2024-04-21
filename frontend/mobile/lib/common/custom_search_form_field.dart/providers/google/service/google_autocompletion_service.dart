import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/local_place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_auto_complete_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_maps_api_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/local/google_auto_completion_last_selected.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/google_auto_completion_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/localized_autocompletion_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';

class GoogleAutocompletionService extends BaseSearchRepository {
  final GoogleMapsApiRepository _repository;
  final String _type;
  final GoogleAutoCompletionLastSelected _localRepo;

  const GoogleAutocompletionService(
    this._repository,
    this._type,
    this._localRepo,
  );

  @override
  Future<BaseSearchResult> search(String term) {
    try {
      return _repository
          .autocomplete(term, _type)
          .then(
            (value) => value.map(
              (e) => PlaceResult(
                preview: e.description,
                value: e.placeId,
              ),
            ),
          )
          .then((value) => value.toList())
          .then((value) => GoogleAutoCompletionSearchResult(items: value));
    } on GoogleMapsApiError catch (error) {
      throw LocalizedAutocompletionError(code: error.code.toString());
    } on DioException {
      throw const LocalizedAutocompletionError(code: networkError);
    } on Exception {
      throw const LocalizedAutocompletionError(code: unknown);
    }
  }

  @override
  GoogleAutoCompletionSearchResult previousSearchResult() {
    return GoogleAutoCompletionSearchResult(
      items: _localRepo
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
    return _localRepo.saveSelected(localPlaceResult);
  }
}

const autoCompleteCity = 'GoogleAutoCompleteCity';
const autoCompleteEstablishment = 'GoogleAutoCompleteEstablishment';
