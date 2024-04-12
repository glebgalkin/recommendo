import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/google/service/models/google_search_result.dart';
import 'package:retrofit/retrofit.dart';

part 'google_maps_remote.g.dart';

@RestApi()
abstract class GoogleMapsRemote {
  factory GoogleMapsRemote(Dio dio) = _GoogleMapsRemote;

  @GET('/maps/api/place/autocomplete/json')
  Future<GoogleMapsSearchResult> getPredictions(
    @Query('input') String term,
    @Query('types') String types,
    @Query('key') String apiKey,
    @Query('sessiontoken') String sessionToken,
  );
}
