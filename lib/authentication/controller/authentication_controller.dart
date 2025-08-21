import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  RxBool passwordVisibility = true.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void onClickLoginButton() {
    String email = emailTextController.text.toString();
    String password = passwordTextController.text.toString();
    createUserWithEmailAndPassword(email: email, password: password);
  }

  String? validateEmail({required String? email}) {
    return null;
  }

  String? validatePassword({required String? password}) {
    return null;
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var auth = FirebaseAuth.instance;

    try {
      var response = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (auth.currentUser != null) {
        mySnackBar(
          title: "Authentication Successful",
          message: "User created: ${auth.currentUser!.uid}",
        );
      } else {
        mySnackBar(
          title: "Authentication Failed",
          message: "Something went wrong, please try again.",
        );
      }
    } on FirebaseAuthException catch (e) {
      // 🔹 Handle common Firebase exceptions
      String message;

      switch (e.code) {
        case "email-already-in-use":
          message = "This email is already registered. Please log in.";
          break;
        case "invalid-email":
          message = "The email address is not valid.";
          break;
        case "weak-password":
          message = "Password is too weak. Use at least 6 characters.";
          break;
        case "operation-not-allowed":
          message = "Email/password accounts are not enabled.";
          break;
        default:
          message = "Unexpected error: ${e.message}";
      }

      mySnackBar(title: "Authentication Failed", message: message);

      debugPrint("FirebaseAuthException: ${e.code} - ${e.message}");
    } catch (error) {
      mySnackBar(
        title: "Authentication Failed",
        message: "An unexpected error occurred. Please try again.",
      );
      debugPrint("Error in createUserWithEmailAndPassword -- $error");
    }
  }

  Future loginUserWithGoogleAccount() async {
    try {


    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: ${e.code} - ${e.message}");
    } catch (error) {
      debugPrint("Error in loginUserWithGoogleAccount -- $error");
    }
  }

  void mySnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
