import 'package:dio/dio.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/google_auto_completion_search_result.dart';
import 'package:retrofit/retrofit.dart';

part 'google_auto_completion_remote.g.dart';

@RestApi()
abstract class GoogleAutoCompletionRemote {
  factory GoogleAutoCompletionRemote(Dio dio) = _GoogleAutoCompletionRemote;

  @GET('/maps/api/place/autocomplete/json')
  Future<GoogleAutoCompletionSearchResult> getPredictions(
    @Query('input') String term,
    @Query('types') String types,
  );
}
