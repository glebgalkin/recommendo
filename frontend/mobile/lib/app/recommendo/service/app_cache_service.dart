import 'package:recommendo/common/app_response.dart';

abstract class AppCacheService {
  Future<AppResponse<int>> getCacheSize();

  Future<AppResponse<int>> clearCache();
}
