import 'package:recommendo/app/auth/service/app_auth_service.dart';

class AppAuthController implements AppAuthService {
  final AppAuthService _delegate;

  const AppAuthController(this._delegate);

  @override
  Future<String?> idToken() {
    return _delegate.idToken();
  }

  @override
  bool isLogged() {
    return _delegate.isLogged();
  }

  @override
  Future<void> signOut() {
    return _delegate.signOut();
  }

  @override
  Stream<bool> authStateChanges() {
    return _delegate.authStateChanges();
  }
}
