import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/user_profile/controller/user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: controller.onPressSignOut,
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : myUserProfileUi(),
          ),
        ),
      ),
    );
  }

  Widget myUserProfileUi() {
    return Center(child: Text("user is login "));
  }
}
