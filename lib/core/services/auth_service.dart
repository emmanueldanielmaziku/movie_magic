import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with google
  Future<User?> signInWithGoogle() async {
    try {
      // Sign out from Google Sign-In to force account selection
      await _googleSignIn.signOut();

      // Clearing the cached account
      await _googleSignIn.signInSilently().then((account) {
        if (account != null) {
          _googleSignIn.disconnect();
        }
      });

      // Initiating the Google Sign-In process
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      if (kDebugMode) {
        print("Error signing out: $e");
      }
    }
  }
}
