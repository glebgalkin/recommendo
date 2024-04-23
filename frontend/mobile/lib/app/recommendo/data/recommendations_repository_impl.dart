import 'package:dio/dio.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_payload_entity.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_response_entity.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_exceptions.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/model/recommendation_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';

class RecommendationsRepositoryImpl implements RecommendationsRepository {
  final RecommendationsRemote _remoteSource;
  final RecommendationsLocal _localSource;

  const RecommendationsRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<bool> createRecommendation({
    required PlaceResult city,
    required String title,
    required SocialLinkType type,
    required String link,
    String? description,
  }) async {
    final cityPayload = CityPayload(name: city.preview, id: city.value);
    final sourcePayload = SourcePayload(type: _typeToString(type), id: link);
    final payload = RecommendationPayloadEntity(
      city: cityPayload,
      title: title,
      sourcePayload: [sourcePayload],
      description: description,
    );

    try {
      await _remoteSource.createRecommendation(payload);
      return true;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.badResponse) {
        final error = _defaultErrorProcessing(exception);
        if (error == 'No recommendation title provided') {
          throw const RecommendationsRepositoryError.invalidTitle();
        }
        if (error == 'No city name is provided' ||
            error == 'No city id is provided') {
          throw const RecommendationsRepositoryError.invalidCity();
        }
        if (error == 'No source provided') {
          throw const RecommendationsRepositoryError.invalidSources();
        }
      }
      rethrow;
    }
  }

  @override
  Future<bool> deleteRecommendation(String id) async {
    try {
      await _remoteSource.deleteRecommendation(id);
      return true;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.badResponse) {
        final error = _defaultErrorProcessing(exception);
        if (error == "Can't delete") {
          throw const RecommendationsRepositoryError.failedDeletion();
        }
      }
      rethrow;
    }
  }

  @override
  Future<RecommendationModel> getRecommendation(String id) async {
    try {
      final result = await _remoteSource.getRecommendation(id);
      return _entityToModel(result);
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.badResponse) {
        final error = _defaultErrorProcessing(exception);
        if (error == 'not found') {
          throw const RecommendationsRepositoryError.notFoundRecommendation();
        }
      }
      rethrow;
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendations({
    required int offset,
    required int limit,
    required String cityId,
    String? term,
  }) async {
    try {
      final result =
          await _remoteSource.getRecommendations(offset, limit, cityId, term);
      return result.map(_entityToModel).toList();
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.badResponse) {
        final error = _defaultErrorProcessing(exception);
        if (error == 'Invalid search') {
          throw const RecommendationsRepositoryError.failedSearch();
        }
      }
      rethrow;
    }
  }

  @override
  List<RecommendationModel> getOfflineRecommendations({
    required int limit,
    required int offset,
    required String cityId,
    String? term,
  }) {
    return _localSource
        .getRecommendations(
          limit: limit,
          offset: offset,
          cityId: cityId,
          term: term,
        )
        .map(_localToModel)
        .toList();
  }

  @override
  void saveToLocal(RecommendationModel model) {
    final localModel = _modelToLocal(model);
    _localSource.saveRecommendation(localModel);
  }

  @override
  bool isSavedOnDevice(RecommendationModel model) {
    return _localSource.containsKey(model.id);
  }

  @override
  Future<void> deleteFromDevice(RecommendationModel model) {
    return _localSource.delete(model.id);
  }

  String _defaultErrorProcessing(DioException exception) {
    final statusCode = exception.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      throw const RecommendationsRepositoryError.serverNotAvailable();
    }
    late final String error;
    try {
      error = (exception.response!.data as Map<String, dynamic>)['message']
          as String;
    } on Exception {
      throw const RecommendationsRepositoryError.unknown();
    }
    if (error == 'Unauthorized') {
      throw const RecommendationsRepositoryError.unauthorized();
    }
    return error;
  }

  RecommendationModel _entityToModel(RecommendationResponseEntity entity) {
    final socialSource = entity.sources
        .map(
          (e) => SocialSource(
            id: e.id,
            type: _typeFromString(e.type),
            extra: e.extra,
          ),
        )
        .toList();
    return RecommendationModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      socialSource: socialSource,
      city: PlaceResult(
        preview: entity.city.name,
        value: entity.city.id,
      ),
    );
  }

  RecommendationLocalModel _modelToLocal(RecommendationModel entity) {
    // final socialSource = entity.sources
    //     .map(
    //       (e) => SocialSource(
    //         id: e.id,
    //         type: _typeFromString(e.type),
    //         extra: e.extra,
    //       ),
    //     )
    //     .toList();
    return RecommendationLocalModel(
      id: entity.id,
      cityId: entity.city.value,
      cityName: entity.city.preview,
      title: entity.title,
      description: entity.description,
      //socialSource: socialSource,
    );
  }

  RecommendationModel _localToModel(RecommendationLocalModel entity) {
    // final socialSource = entity.sources
    //     .map(
    //       (e) => SocialSource(
    //         id: e.id,
    //         type: _typeFromString(e.type),
    //         extra: e.extra,
    //       ),
    //     )
    //     .toList();
    return RecommendationModel(
      id: entity.id,
      city: PlaceResult(preview: entity.cityName, value: entity.cityId),
      title: entity.title,
      description: entity.description,
      socialSource: const [],
      //socialSource: socialSource,
    );
  }

  String _typeToString(SocialLinkType type) {
    return switch (type) {
      SocialLinkType.googleMaps => 'GOOGLE_API',
      SocialLinkType.instagram => 'INSTAGRAM',
      _ => throw const RecommendationsRepositoryError.invalidSources(),
    };
  }

  SocialLinkType _typeFromString(String type) {
    return switch (type) {
      'GOOGLE_API' => SocialLinkType.googleMaps,
      'INSTAGRAM' => SocialLinkType.instagram,
      _ => SocialLinkType.unknown,
    };
  }
}
