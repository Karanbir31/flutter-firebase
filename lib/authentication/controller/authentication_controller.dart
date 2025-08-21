import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthenticationController extends GetxController {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  RxBool passwordVisibility = true.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void onClickLoginButton(){

  }

  String? validateEmail({required String? email}){
    return null;
  }
 String? validatePassword({required String? password}){
    return null;
  }



}
