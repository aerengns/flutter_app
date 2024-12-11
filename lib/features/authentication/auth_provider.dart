import 'package:drive_or_drunk_app/features/authentication/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  User? get currentUser => _authRepository.currentUser;
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      await _authRepository.signUp(
          email: email, password: password, displayName: displayName);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _authRepository.signIn(email: email, password: password);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     await _authRepository.signInWithGoogle();
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> signInWithFacebook() async {
  //   try {
  //     await _authRepository.signInWithFacebook();
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> resetPassword(String email) async {
    await _authRepository.resetPassword(email);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    notifyListeners();
  }
}
