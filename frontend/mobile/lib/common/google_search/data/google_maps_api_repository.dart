import 'package:recommendo/common/google_search/data/entity/maps_api_status.dart';
import 'package:recommendo/common/google_search/data/entity/place_autocomplete_response.dart';
import 'package:recommendo/common/google_search/data/entity/reverse_geocoding_response.dart';
import 'package:recommendo/common/google_search/data/google_auto_complete_error.dart';
import 'package:recommendo/common/google_search/data/remote/google_maps_api_remote.dart';

class GoogleMapsApiRepository {
  const GoogleMapsApiRepository(this._remote);

  final GoogleMapsApiRemote _remote;

  Future<List<PlaceAutocompletePrediction>> autocomplete(
    String term,
    String type,
  ) async {
    final response = await _remote.autocomplete(term, type);

    switch (response.status) {
      case MapsApiStatus.ok:
        return response.predictions;
      case MapsApiStatus.zeroResults:
        return const [];
      case MapsApiStatus.invalidRequest:
        throw const GoogleMapsApiError.invalidRequest();
      case MapsApiStatus.overQueryLimit:
        throw const GoogleMapsApiError.overQueryLimit();
      case MapsApiStatus.requestDenied:
        throw const GoogleMapsApiError.requestDenied();
      case MapsApiStatus.unknownError:
        throw const GoogleMapsApiError.googleUnknown();
    }
  }

  Future<ReverseGeocodingResult?> reverseGeocoding(
    String latlng,
    String type,
  ) async {
    final response = await _remote.geocoding(latlng, type);

    switch (response.status) {
      case MapsApiStatus.ok:
        return response.results[0];
      case MapsApiStatus.zeroResults:
        return null;
      case MapsApiStatus.invalidRequest:
        throw const GoogleMapsApiError.invalidRequest();
      case MapsApiStatus.overQueryLimit:
        throw const GoogleMapsApiError.overQueryLimit();
      case MapsApiStatus.requestDenied:
        throw const GoogleMapsApiError.requestDenied();
      case MapsApiStatus.unknownError:
        throw const GoogleMapsApiError.googleUnknown();
    }
  }
}
