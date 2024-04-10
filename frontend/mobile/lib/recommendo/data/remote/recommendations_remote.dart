import 'package:dio/dio.dart';
import 'package:recommendo/recommendo/data/entity/recommendation_payload_entity.dart';
import 'package:recommendo/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'recommendations_remote.g.dart';

@RestApi()
abstract class RecommendationsRemote {
  factory RecommendationsRemote(Dio dio) = _RecommendationsRemote;

  @GET('/recommendation/{id}')
  Future<RecommendationResponseEntity> getRecommendation(@Path() String id);

  @GET('/recommendation')
  Future<List<RecommendationResponseEntity>> getRecommendations(
    @Path() int offset,
    @Path() int limit,
  );

  @DELETE('/recommendation/{id}')
  Future<void> deleteRecommendation(@Path() String id);

  @POST('/recommendation')
  Future<void> createRecommendation(@Body() RecommendationPayloadEntity model);
}
