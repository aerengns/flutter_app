import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Email & Password Registration
  Future<User?> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update display name if provided
      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Email & Password Login
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Google Sign-In
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     if (googleAuth == null) return null;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential userCredential =
  //         await _firebaseAuth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (e) {
  //     throw Exception('Google Sign-In Failed: $e');
  //   }
  // }

  // Facebook Sign-In
  // Future<User?> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();

  //     if (result.status == LoginStatus.success) {
  //       final OAuthCredential credential = FacebookAuthProvider.credential(
  //         result.accessToken!.token
  //       );

  //       final UserCredential userCredential = await _firebaseAuth
  //           .signInWithCredential(credential);
  //       return userCredential.user;
  //     }
  //     return null;
  //   } catch (e) {
  //     throw Exception('Facebook Sign-In Failed: $e');
  //   }
  // }

  // Password Reset
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
  }

  // Error Handling
  Exception _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return Exception('The password is too weak.');
      case 'email-already-in-use':
        return Exception('An account already exists with this email.');
      case 'invalid-email':
        return Exception('The email address is not valid.');
      case 'user-not-found':
        return Exception('No user found with this email.');
      case 'wrong-password':
        return Exception('Incorrect password.');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }

  // Current User
  User? get currentUser => _firebaseAuth.currentUser;

  // Stream of Authentication State
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
