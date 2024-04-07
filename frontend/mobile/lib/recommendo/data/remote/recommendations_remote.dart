import 'package:dio/dio.dart';
import 'package:recommendo/recommendo/data/entity/recommendation_payload_entity.dart';
import 'package:recommendo/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'recommendations_remote.g.dart';

@RestApi()
abstract class RecommendationsRemote {
  factory RecommendationsRemote(Dio dio) = _RecommendationsRemote;

  @GET('/recommendation/{id}')
  Future<RecommendationResponseEntity> getRecommendation(@Path('id') String id);

  @GET('/recommendation')
  Future<List<RecommendationResponseEntity>> getRecommendations();

  @DELETE('/recommendation/{id}')
  Future<void> deleteRecommendation(@Path('id') String id);

  @POST('/recommendation')
  Future<void> createRecommendation(@Body() RecommendationPayloadEntity model);
}
