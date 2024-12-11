import 'package:drive_or_drunk_app/features/authentication/firebase_auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  Future<User?> signIn({
    required String email,
    required String password,
  });

  // Future<User?> signInWithGoogle();
  // Future<User?> signInWithFacebook();
  Future<void> resetPassword(String email);
  Future<void> signOut();
  User? get currentUser;
  Stream<User?> get authStateChanges;
}

// lib/features/authentication/data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<User?> signUp({
    required String email,
    required String password,
    String? displayName,
  }) =>
      _authDataSource.signUp(
          email: email, password: password, displayName: displayName);

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) =>
      _authDataSource.signIn(email: email, password: password);

  // @override
  // Future<User?> signInWithGoogle() => _authDataSource.signInWithGoogle();

  // @override
  // Future<User?> signInWithFacebook() => _authDataSource.signInWithFacebook();

  @override
  Future<void> resetPassword(String email) =>
      _authDataSource.resetPassword(email);

  @override
  Future<void> signOut() => _authDataSource.signOut();

  @override
  User? get currentUser => _authDataSource.currentUser;

  @override
  Stream<User?> get authStateChanges => _authDataSource.authStateChanges;
}
