import 'package:dio/dio.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_payload_entity.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/place_result.dart';

typedef _GetDataCallback<T> = Future<T> Function();

class RecommendationsRepositoryImpl implements RecommendationsRepository {
  final RecommendationsRemote _remoteSource;
  // ignore: unused_field
  final RecommendationsLocal _localSource;

  const RecommendationsRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<AppResponse<bool>> createRecommendation({
    required PlaceResult city,
    required String title,
    required String type,
    required String link,
    String? description,
  }) {
    final cityPayload = CityPayload(name: city.preview, id: city.value);
    final sourcePayload = SourcePayload(type: type, id: link);
    final payload = RecommendationPayloadEntity(
      city: cityPayload,
      title: title,
      sourcePayload: [sourcePayload],
      description: description,
    );

    return _remoteSource
        .createRecommendation(payload)
        .then((_) => const AppResponse(result: true));
  }

  @override
  Future<AppResponse<bool>> deleteRecommendation(String id) {
    return _handleErrors(
      () {
        return _remoteSource.deleteRecommendation(id).then((_) => true);
      },
    );
  }

  @override
  Future<AppResponse<RecommendationModel>> getRecommendation(String id) {
    return _handleErrors(
      () {
        return _remoteSource.getRecommendation(id).then(_entityToModel);
      },
    );
  }

  @override
  Future<AppResponse<List<RecommendationModel>>> getRecommendations({
    required int offset,
    required int limit,
    required String cityId,
    String? term,
  }) {
    return Future.value(
      AppResponse(
        result: offset >= 45
            ? []
            : List.generate(10, (index) {
                final id = index + offset;
                return RecommendationModel(
                  id: id.toString(),
                  city: 'asd',
                  title: 'title-id',
                  address: 'ASDASDASDASDAD',
                  description: 'ASdadasd',
                  socialLink: 'instagram',
                );
              }),
      ),
    );
  }

  Future<AppResponse<T>> _handleErrors<T>(_GetDataCallback<T> callback) async {
    try {
      final result = await callback();
      return AppResponse(result: result);
    } on DioException catch (e) {
      final fail = Failure.fromDio(e);
      return AppResponse<T>(error: fail);
    } on Exception catch (e) {
      final fail = Failure(exception: e, msg: 'Unknown error');
      return AppResponse<T>(error: fail);
    }
  }

  RecommendationModel _entityToModel(RecommendationResponseEntity entity) {
    return RecommendationModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      socialLink: entity.socialLink,
      city: entity.city,
      address: entity.address,
    );
  }
}
