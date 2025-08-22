import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/foundation.dart';

class FacebookAuthService {
  static const String _tag = "------FacebookAuthService-------";

  static Future<UserCredential?> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email']);

      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken;
        if (accessToken != null) {
          final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.tokenString);

          return await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
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
}
