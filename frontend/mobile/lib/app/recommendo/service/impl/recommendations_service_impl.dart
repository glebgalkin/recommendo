import 'package:dio/dio.dart';
import 'package:recommendo/app/recommendo/data/recommendations_repository_exceptions.dart';
import 'package:recommendo/app/recommendo/service/model/recommended_place_model.dart';
import 'package:recommendo/app/recommendo/service/model/social_source.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/app/recommendo/service/repository/recommendations_repository.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/custom_search_form_field.dart/providers/google/service/models/place_result.dart';
import 'package:recommendo/common/localized_error_text.dart';

class RecommendationsServiceImpl implements RecommendationService {
  final RecommendationsRepository _repository;

  const RecommendationsServiceImpl(this._repository);

  @override
  Future<AppResponse<bool>> createRecommendation({
    required PlaceResult city,
    required String title,
    required SocialLinkType type,
    required String link,
    String? description,
  }) async {
    try {
      final result = await _repository.createRecommendation(
        city: city,
        title: title,
        type: type,
        link: link,
        description: description,
      );
      return AppResponse.success(result);
    } on RecommendationsRepositoryError catch (e) {
      final result = _defaultRecommendationRepoErrorHandling<bool>(e);
      if (result != null) return result;
      return switch (e.code) {
        RecommendationsErrorCode.invalidTitle => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsInvalidTitle,
            ),
          ),
        RecommendationsErrorCode.invalidCity => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsInvalidCity,
            ),
          ),
        RecommendationsErrorCode.invalidSources => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsInvalidSources,
            ),
          ),
        _ => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsUnknown,
            ),
          ),
      };
    } on DioException catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.defaultNetworkError),
      );
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }

  @override
  Future<AppResponse<RecommendedPlaceModel>> getRecommendation({
    required String id,
  }) async {
    try {
      final result = await _repository.getRecommendation(id);
      return AppResponse.success(result);
    } on RecommendationsRepositoryError catch (e) {
      final result =
          _defaultRecommendationRepoErrorHandling<RecommendedPlaceModel>(e);
      if (result != null) return result;
      return switch (e.code) {
        RecommendationsErrorCode.notFoundRecommendation => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsNotFoundRecommendation,
            ),
          ),
        _ => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsUnknown,
            ),
          ),
      };
    } on DioException catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.defaultNetworkError),
      );
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }

  @override
  Future<AppResponse<List<RecommendedPlaceModel>>> getRecommendations({
    required PlaceResult cityResult,
    int offset = 0,
    int limit = 10,
    String? term,
  }) async {
    try {
      final result = List.generate(
        limit,
        (index) => RecommendedPlaceModel(
          id: (index + offset).toString(),
          title:
              'T:$term ${cityResult.preview.substring(0, 4)} ${index + offset}',
          description:
              'ksdjfkjsd fkjsdbfksdjbfkjsdbfkjds bfkjsdbfkjsdbjkfkjsbdf',
          rating: 4.6,
          uniqueRecommendations: 12,
          sources: const [],
        ),
      );
      // final result = await _repository.getRecommendations(
      //   offset: offset,
      //   limit: limit,
      //   cityId: cityResult.value,
      //   term: term,
      // );
      return AppResponse.success(result);
    } on RecommendationsRepositoryError catch (e) {
      final result =
          _defaultRecommendationRepoErrorHandling<List<RecommendedPlaceModel>>(
              e);
      if (result != null) return result;
      return switch (e.code) {
        RecommendationsErrorCode.failedSearch => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsFailedSearch,
            ),
          ),
        _ => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsUnknown,
            ),
          ),
      };
    } on DioException catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.defaultNetworkError),
      );
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }

  @override
  Future<AppResponse<List<String>>> getSearchTags({
    required String cityId,
  }) async {
    try {
      final result = List.generate(
        10,
        (index) => 'String $index',
      );
      //final result2 = await _repository.getSearchTags();
      return AppResponse.success(result);
    } on RecommendationsRepositoryError catch (e) {
      final result = _defaultRecommendationRepoErrorHandling<List<String>>(e);
      if (result != null) return result;
      return switch (e.code) {
        RecommendationsErrorCode.failedSearch => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsFailedSearch,
            ),
          ),
        _ => AppResponse.error(
            Failure(
              exception: e,
              code: LocalizedErrorMessage.recommendationsUnknown,
            ),
          ),
      };
    } on DioException catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.defaultNetworkError),
      );
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }

  AppResponse<T>? _defaultRecommendationRepoErrorHandling<T>(
    RecommendationsRepositoryError e,
  ) {
    return switch (e.code) {
      RecommendationsErrorCode.serverNotAvailable => AppResponse.error(
          Failure(
            exception: e,
            code: LocalizedErrorMessage.recommendationsServerNotAvailable,
          ),
        ),
      RecommendationsErrorCode.unauthorized => AppResponse.error(
          Failure(
            exception: e,
            code: LocalizedErrorMessage.recommendationsUnauthorized,
          ),
        ),
      RecommendationsErrorCode.unknown => AppResponse.error(
          Failure(
            exception: e,
            code: LocalizedErrorMessage.recommendationsUnknown,
          ),
        ),
      _ => null,
    };
  }
}
