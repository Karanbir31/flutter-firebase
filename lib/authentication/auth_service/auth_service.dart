import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static const String _tag = "--Authentication Service--";

  static final _googleSignIn = GoogleSignIn.instance;
  static bool _isGoogleSignInInitialized = false;

  AuthService() {
    _initializeGoogleSignIn();
  }

  static Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var response = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (auth.currentUser != null) {
        //"Authentication Successful",
      } else {
        // authentication failed
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case "email-already-in-use":
          _signInUserWithEmailAndPassword(email: email, password: password);
          break;
        default:
          message = "Unexpected error: ${e.message}";
      }

      debugPrint("$_tag FirebaseAuthException: ${e.code} - ${e.message}");
    } catch (error) {
      debugPrint("$_tag Error in createUserWithEmailAndPassword -- $error");
    }
  }

  static Future<void> _signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      debugPrint("$_tag Error in createUserWithEmailAndPassword -- $error");
    }
  }

  /// Firebase authentication using Facebook account
  static Future<UserCredential?> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken;
        if (accessToken != null) {
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(accessToken.tokenString);

          return await FirebaseAuth.instance.signInWithCredential(
            facebookAuthCredential,
          );
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        debugPrint("$_tag Login cancelled by user.");
      } else if (loginResult.status == LoginStatus.failed) {
        debugPrint("$_tag Login failed: ${loginResult.message}");
      }

      return null;
    } catch (e) {
      debugPrint("$_tag Login error: $e");
      return null;
    }
  }

  /// Firebase authentication using Google account
  static Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize Google Sign-In: $e');
    }
  }

  /// Always check Google sign in initialization before use
  static Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    // Authenticate with Google
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Get authorization for Firebase scopes if needed
    final authClient = _googleSignIn.authorizationClient;
    final authorization = await authClient.authorizationForScopes(['email']);

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    // Update local state

    return userCredential;
  }
}
