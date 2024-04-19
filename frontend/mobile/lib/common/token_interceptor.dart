import 'package:dio/dio.dart';
import 'package:recommendo/app/auth/view/service/app_auth_controller.dart';

class TokenInterceptor extends Interceptor {
  const TokenInterceptor(this._appAuthController);

  final AppAuthController _appAuthController;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_appAuthController.isLogged()) {
      return _rejectUnauthorized(handler, options);
    }
    final token = await _appAuthController.idToken();

    if (token == null || token.isEmpty) {
      return _rejectUnauthorized(handler, options);
    }

    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  void _rejectUnauthorized(
    RequestInterceptorHandler handler,
    RequestOptions options,
  ) {
    return handler.reject(
      DioException.badResponse(
        statusCode: 401,
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 401,
          statusMessage: 'Unauthorized',
        ),
      ),
    );
  }
}
