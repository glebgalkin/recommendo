import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_local.dart';
import 'package:recommendo/app/recommendo/data/entity/recommendation_payload_entity.dart';
import 'package:recommendo/app/recommendo/data/entity/recommended_place_feed_response.dart';
import 'package:recommendo/app/recommendo/data/local/recommendations_local.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_exception.dart';
import 'package:recommendo/app/recommendo/data/remote/recommendations_remote.dart';
import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';

class RecommendationsRepositoryImpl implements RecommendationsRepository {
  final RecommendationsRemote _remoteSource;

  final RecommendationsLocal _localSource;

  const RecommendationsRepositoryImpl(this._remoteSource, this._localSource);

  @override
  Future<bool> createRecommendation({
    required String cityId,
    required String title,
    required SocialLinkType type,
    required String link,
    String? description,
  }) async {
    final sourcePayload = SourcePayload(type: _typeToString(type), id: link);
    final payload = RecommendationPayloadEntity(
      cityId: cityId,
      title: title,
      source: [sourcePayload],
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
  Future<RecommendedPlaceModel> getRecommendation(String id) async {
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
  Future<List<RecommendedPlaceModel>> getRecommendations({
    required int offset,
    required int limit,
    required String cityId,
    bool searchOnDevice = false,
    String? term,
  }) async {
    if (searchOnDevice) {
      try {
        final result = await _localSource.getRecommendations(
          limit: limit,
          offset: offset,
          cityId: cityId,
          term: term,
        );
        return result.map(_localModelToModel).toList();
      } on Exception {
        throw const RecommendationsRepositoryError.failedSearchLocal();
      }
    }

    try {
      final result =
          await _remoteSource.getRecommendations(offset, limit, cityId, term);

      final local = result.map((e) => _entityToLocalModel(e, cityId)).toList();
      await _localSource.saveRecommendations(local);

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

  String _defaultErrorProcessing(DioException exception) {
    final statusCode = exception.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      throw const RecommendationsRepositoryError.serverNotAvailable();
    }
    late final String error;
    try {
      if (exception.response == null) {
        throw const RecommendationsRepositoryError.unknown();
      }
      final data = exception.response!.data;
      if (data is Map<String, dynamic>) {
        error = data['message'] as String;
      }
      if (data is String) {
        error = (jsonDecode(exception.response!.data as String)
            as Map<String, dynamic>)['message'] as String;
      }
      // ignore: avoid_catching_errors
    } on Error {
      throw const RecommendationsRepositoryError.unknown();
    }
    if (error == 'Unauthorized') {
      throw const RecommendationsRepositoryError.unauthorized();
    }
    return error;
  }

  RecommendedPlaceModel _entityToModel(RecommendedPlaceFeedResponse entity) {
    final socialSource = entity.sources
        .map(
          (e) => SocialSource(
            id: e.id,
            type: _typeFromString(e.type),
          ),
        )
        .toList();
    return RecommendedPlaceModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      img: entity.img,
      sources: socialSource,
      recommendedCount: entity.recommendedCount,
    );
  }

  RecommendedPlaceModel _localModelToModel(RecommendationLocalModel entity) {
    final socialSource = entity.socialSource
        .map(
          (e) => SocialSource(
            id: e.id!,
            type: _typeFromString(e.type!),
          ),
        )
        .toList();
    return RecommendedPlaceModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      img: entity.img,
      sources: socialSource,
      recommendedCount: entity.recommendedCount,
    );
  }

  RecommendationLocalModel _entityToLocalModel(
    RecommendedPlaceFeedResponse entity,
    String cityId,
  ) {
    final socialSource = entity.sources
        .map(
          (e) => SocialSourceLocal()
            ..id = e.id
            ..type = e.type,
        )
        .toList();
    return RecommendationLocalModel(
      id: entity.id,
      cityId: cityId,
      title: entity.title,
      description: entity.description,
      img: entity.img,
      socialSource: socialSource,
      recommendedCount: entity.recommendedCount,
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
