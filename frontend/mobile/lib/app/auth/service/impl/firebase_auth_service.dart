import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:recommendo/app/auth/service/app_auth_service.dart';

class FirebaseAuthService implements AppAuthService {
  @override
  Future<String?> idToken() {
    return FirebaseAuth.instance.currentUser!.getIdToken();
  }

  @override
  bool isLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signOut() {
    FirebaseAuth.instance.authStateChanges();
    return FirebaseAuth.instance.signOut();
  }

  @override
  Stream<bool> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges().transform<bool>(
          StreamTransformer.fromHandlers(
            handleData: (data, sink) => data != null,
          ),
        );
  }
}
