import 'package:dio/dio.dart';

class AppResponse<T> {
  final T? result;

  final Failure? error;

  const AppResponse({
    this.result,
    this.error,
  });

  @override
  String toString() {
    if (result != null) {
      return 'AppResponse: Success: $result';
    } else if (error != null) {
      return 'AppResponse: Failure: $error';
    } else {
      return 'AppResponse: Uninitialized';
    }
  }
}

class Failure {
  final Exception exception;
  final String msg;

  const Failure({
    required this.exception,
    required this.msg,
  });

  Failure.fromDio(DioException dioException)
      : exception = dioException,
        msg = dioException.response?.statusMessage ?? 'Проблема с сетью';
}
