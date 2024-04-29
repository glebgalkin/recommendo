import 'package:recommendo/common/localized_error_text.dart';

class AppResponse<T> {
  final T? result;

  final Failure? error;

  const AppResponse._({
    this.result,
    this.error,
  });

  const AppResponse.success(T? result) : this._(result: result);

  const AppResponse.error(Failure error) : this._(error: error);

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
  final Exception? exception;
  // For localization
  final LocalizedErrorMessage? code;

  const Failure({
    this.exception,
    this.code,
  });
}
