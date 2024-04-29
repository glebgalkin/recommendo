import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/local_place_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_auto_complete_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_maps_api_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/local/google_auto_completion_local.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/google_auto_completion_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/localized_error_text.dart';

class GoogleAutocompletionService extends BaseSearchRepository {
  final GoogleMapsApiRepository _repository;
  final String _type;
  final GoogleAutoCompletionLocal _localRepo;

  const GoogleAutocompletionService(
    this._repository,
    this._type,
    this._localRepo,
  );

  @override
  Future<BaseSearchResult> search(String term) async {
    try {
      final result = await _repository.autocomplete(term, _type);
      final resultList = result
          .map((e) => PlaceResult(preview: e.description, value: e.placeId))
          .toList();
      return GoogleAutoCompletionSearchResult(items: resultList);
    } on GoogleMapsApiError catch (error) {
      throw switch (error.code) {
        MapsApiErrorCode.invalidRequest => const SearchResultError(
            LocalizedErrorMessage.mapsApiAutocompleteInvalidRequest,
          ),
        MapsApiErrorCode.overQueryLimit => const SearchResultError(
            LocalizedErrorMessage.defaultMapsApiOverQueryLimit,
          ),
        _ => const SearchResultError(
            LocalizedErrorMessage.deafultMapsApiError,
          ),
      };
    } on DioException {
      throw const SearchResultError(LocalizedErrorMessage.defaultNetworkError);
    } on Exception {
      throw const SearchResultError(LocalizedErrorMessage.unknown);
    }
  }

  @override
  GoogleAutoCompletionSearchResult offlineSearch(String term) {
    try {
      final result = _localRepo
          .getAll()
          .where((element) => element.preview.contains(term))
          .map((e) => PlaceResult(preview: e.preview, value: e.value))
          .toList();
      return GoogleAutoCompletionSearchResult(items: result);
    } on Exception {
      throw const SearchResultError(
        LocalizedErrorMessage.mapsApiAutocompleteLocalSearchError,
      );
    }
  }

  @override
  GoogleAutoCompletionSearchResult previousSearchResult() {
    try {
      final result = _localRepo
          .getAll(length: 5)
          .map((e) => PlaceResult(preview: e.preview, value: e.value))
          .toList();
      return GoogleAutoCompletionSearchResult(items: result);
    } on Exception {
      return const GoogleAutoCompletionSearchResult(items: []);
    }
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
