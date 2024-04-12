import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/google_maps_remote.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_search_result.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_search_result_error.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/base_search_repository.dart';

class GoogleMapsRepository extends BaseSearchRepository {
  static const _types = '(cities)';

  const GoogleMapsRepository(
    this._remote,
    this._apiKey,
    this._sessionToken,
  );

  final GoogleMapsRemote _remote;
  final String _apiKey;
  final String _sessionToken;

  @override
  Future<GoogleMapsSearchResult> search(String term) {
    try {
      return _remote.getPredictions(term, _types, _apiKey, _sessionToken);
    } on DioException {
      throw const GoogleMapsSearchResultError(
        message: 'Google is not available',
      );
    }
  }
}
