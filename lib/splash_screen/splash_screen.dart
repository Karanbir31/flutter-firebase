import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to AuthenticationScreen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(NavRoutes.userProfileRoute);
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 App Logo or Firebase Logo
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.flutter_dash,
                  size: 64,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "My Firebase App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
