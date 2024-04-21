import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/place_autocomplete_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/data/entity/reverse_geocoding_response.dart';
import 'package:retrofit/retrofit.dart';

part 'google_maps_api_remote.g.dart';

@RestApi()
abstract class GoogleMapsApiRemote {
  factory GoogleMapsApiRemote(Dio dio) = _GoogleMapsApiRemote;

  @GET('/maps/api/place/autocomplete/json')
  Future<PlaceAutocompleteResponse> autocomplete(
    @Query('input') String term,
    @Query('types') String types,
  );

  @GET('/maps/api/geocode/json')
  Future<ReverseGeoocodingResponse> geocoding(
    @Query('latlng') String term,
    @Query('result_type') String type,
  );
}
