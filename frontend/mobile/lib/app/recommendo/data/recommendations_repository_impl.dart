import 'package:dio/dio.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_payload_entity.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:recommendo/app/recommendo/data/entity/social_links_entity.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_links_model.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/models/city_result.dart';

typedef _GetDataCallback<T> = Future<T> Function();

class RecommendationsRepositoryImpl implements RecommendationsRepository {
  final RecommendationsRemote _remoteSource;
  // ignore: unused_field
  final RecommendationsLocal _localSource;

  const RecommendationsRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<AppResponse<bool>> createRecommendation({
    required CityResult city,
    required String title,
    required SocialLinks links,
    String? description,
  }) {
    return _handleErrors(() async {
      final linksEntity = SocialLinksEntity(
        instagram: links.instagram,
        facebook: links.instagram,
        telegram: links.instagram,
        webSite: links.instagram,
      );
      final payload = RecommendationPayloadEntity(
        city: city,
        title: title,
        description: description,
        socialLinks: linksEntity,
      );
      return _remoteSource.createRecommendation(payload).then((_) => true);
    });
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
  }) {
    return _handleErrors(
      () {
        return _remoteSource
            .getRecommendations(offset, limit)
            .then((response) => response.map(_entityToModel))
            .then((iterable) => iterable.toList());
      },
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
    final socialLinks = SocialLinks(
      instagram: entity.socialLinks.instagram,
      facebook: entity.socialLinks.facebook,
      webSite: entity.socialLinks.webSite,
    );
    return RecommendationModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      socialLinks: socialLinks,
      city: entity.city,
      address: entity.address,
    );
  }
}
