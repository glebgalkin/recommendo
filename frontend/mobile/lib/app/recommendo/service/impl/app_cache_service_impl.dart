import 'package:recommendo/app/recommendo/data/app_cache_repository_exception.dart';
import 'package:recommendo/app/recommendo/service/app_cache_service.dart';
import 'package:recommendo/app/recommendo/service/repository/app_cache_repository.dart';
import 'package:recommendo/common/app_response.dart';
import 'package:recommendo/common/localized_error_text.dart';

class AppCacheServiceImpl implements AppCacheService {
  final AppCacheRepository _repository;

  const AppCacheServiceImpl(this._repository);

  @override
  Future<AppResponse<int>> clearCache() async {
    try {
      final result = await _repository.clearCache();
      return AppResponse.success(result);
    } on AppCacheRepositoryException catch (e) {
      if (e.code == AppCacheErrorCode.failedClearCache) {
        return AppResponse.error(
          Failure(
            exception: e,
            code: LocalizedErrorMessage.appCacheFailedClearCache,
          ),
        );
      } else {
        return AppResponse.error(
          Failure(exception: e, code: LocalizedErrorMessage.unknown),
        );
      }
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }

  @override
  Future<AppResponse<int>> getCacheSize() async {
    try {
      final result = await _repository.getCacheSize();
      return AppResponse.success(result);
    } on AppCacheRepositoryException catch (e) {
      if (e.code == AppCacheErrorCode.failedGettingCacheSize) {
        return AppResponse.error(
          Failure(
            exception: e,
            code: LocalizedErrorMessage.appCacheFailedGettingCacheSize,
          ),
        );
      } else {
        return AppResponse.error(
          Failure(exception: e, code: LocalizedErrorMessage.unknown),
        );
      }
    } on Exception catch (e) {
      return AppResponse.error(
        Failure(exception: e, code: LocalizedErrorMessage.unknown),
      );
    }
  }
}
