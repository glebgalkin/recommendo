abstract class AppAuthService {
  Future<void> signOut();

  Future<String?> idToken();

  bool isLogged();

  Stream<bool> authStateChanges();
}
