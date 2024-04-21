import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/place_autocomplete_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/google_auto_complete_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/remote/google_auto_completion_remote.dart';

class GoogleMapsApiRepository {
  const GoogleMapsApiRepository(this._remote);

  final GoogleAutoCompletionRemote _remote;

  Future<List<PlaceAutocompletePrediction>> search(
    String term,
    String type,
  ) async {
    final response = await _remote.getPredictions(term, type);

    switch (response.status) {
      case AutoompleteStatus.ok:
        return response.predictions;
      case AutoompleteStatus.zeroResults:
        return const [];
      case AutoompleteStatus.invalidRequest:
        throw const GoogleAutoCompleteError.invalidRequest();
      case AutoompleteStatus.overQueryLimit:
        throw const GoogleAutoCompleteError.overQueryLimit();
      case AutoompleteStatus.requestDenied:
        throw const GoogleAutoCompleteError.requestDenied();
      case AutoompleteStatus.unknownError:
        throw const GoogleAutoCompleteError.googleUnknown();
    }
  }
}
