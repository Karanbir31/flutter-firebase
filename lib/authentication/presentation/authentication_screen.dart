import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/authentication/controller/authentication_controller.dart';

class AuthenticationScreen extends GetView<AuthenticationController> {
  AuthenticationScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,

          children: [
            FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.lightBlue.shade200,
                      Colors.blue,
                      Colors.indigo,
                      Colors.purple,
                      Colors.deepPurpleAccent,
                    ],
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  ),
                ),
              ),
            ),

            FractionallySizedBox(
              widthFactor: 0.85,
              heightFactor: 0.75,
              child: userSignUpView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget userSignUpView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),

      child: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,

            children: [
              SizedBox(height: 12),

              CircleAvatar(radius: 64, backgroundColor: Colors.grey),

              Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: myInputFlied(
                  label: "Email",
                  textController: controller.emailTextController,
                  textInputType: TextInputType.emailAddress,
                  textVisibility: false,
                  validator: (value) => controller.validateEmail(email: value),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Obx(
                  () => myInputFlied(
                    label: "Password",
                    textController: controller.emailTextController,
                    textInputType: TextInputType.emailAddress,
                    textVisibility: controller.passwordVisibility.value,
                    validator: (value) =>
                        controller.validatePassword(password: value),
                  ),
                ),
              ),

              myActionButton(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "or login with",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                    backgroundColor: Colors.grey[50],
                  ),
                ),
              ),

              // google facebook etc auth2 row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.gear),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.gear),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.gear),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myInputFlied({
    required String label,
    required TextEditingController textController,
    required TextInputType textInputType,
    required bool textVisibility,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: textController,
      keyboardType: textInputType,
      obscureText: textVisibility,
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(fontSize: 14)),
        suffixIcon: textVisibility
            ? IconButton(
                onPressed: controller.togglePasswordVisibility,
                icon: Icon(
                  controller.passwordVisibility.value
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                ),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget myActionButton() {
    return ElevatedButton(
      onPressed: controller.onClickLoginButton,

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 20),
        padding: EdgeInsets.symmetric(horizontal: 12),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text("Login"),
    );
  }
}
