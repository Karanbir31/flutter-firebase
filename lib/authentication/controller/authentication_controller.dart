import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/authentication/auth_service/auth_service.dart';
import 'package:my_firebase/main.dart';

class AuthenticationController extends GetxController {
  static const String _tag = "--AuthenticationController--";

  static late FirebaseAuth firebaseAuth;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  RxBool passwordVisibility = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint("$_tag User is currently signed out!");
      } else {
        Get.offNamed(
          NavRoutes.userProfileRoute,
          arguments: {'data': "USER_SIGN_IN"},
        );
        debugPrint("$_tag User is signed in: ${user.email}");
      }
    });
  }

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void onClickLoginButton() {
    String email = emailTextController.text.toString();
    String password = passwordTextController.text.toString();
    AuthService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void signInWithGoogle() async {
    try {
      AuthService.signInWithGoogle();
    } catch (error) {
      debugPrint("after Google login failed -->> $error");
      mySnackBar(title: "Google login failed", message: " ");
    }
  }

  Future<void> signInWithFaceBook() async {
    try {
      AuthService.loginWithFacebook();
    } catch (error) {
      debugPrint("after facebook login failed -->> $error");
      mySnackBar(title: "facebook login failed", message: " ");
    }
  }

  String? validateEmail({required String? email}) {
    return null;
  }

  String? validatePassword({required String? password}) {
    return null;
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
