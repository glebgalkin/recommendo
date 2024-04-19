import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/place_autocomplete_response.dart';
import 'package:retrofit/retrofit.dart';

part 'google_auto_completion_remote.g.dart';

@RestApi()
abstract class GoogleAutoCompletionRemote {
  factory GoogleAutoCompletionRemote(Dio dio) = _GoogleAutoCompletionRemote;

  @GET('/maps/api/place/autocomplete/json')
  Future<PlaceAutocompleteResponse> getPredictions(
    @Query('input') String term,
    @Query('types') String types,
  );

  // @GET('/maps/api/geocode/json')
  // Future<GoogleAutoCompletionSearchResult> getCityFromLocation(
  //   @Query('latlng') String term,
  //   @Query('result_type') String type,
  //   @Query('language') String lang,
  // );
}
