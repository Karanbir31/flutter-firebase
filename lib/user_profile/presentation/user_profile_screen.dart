import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/user_profile/controller/user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    if (arguments != null) {
      controller.loadUserData();
    }

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
          () => FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: controller.isLoading.value
                ? Center(
                    child: SizedBox(
                      width: Get.width * 0.2,
                      height: Get.width * 0.2,
                      child: CircularProgressIndicator(
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  )
                : myUserProfileUi(),
          ),
        ),
      ),
    );
  }

  Widget myUserProfileUi() {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,

          children: [

            SizedBox(width: double.infinity, height: 16,),

            Center(
              child: Container(
                width: Get.width * 0.3,
                height: Get.width * 0.3,

                decoration: BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.hardEdge,

                child: Image(
                  image: NetworkImage(controller.userImageUrl.value),
                ),
              ),
            ),

            userDetailsItem("Name", controller.userName.value),

            userDetailsItem("Email", controller.userEmail.value),


          ],
        ),
      ),
    );
  }

  Widget userDetailsItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.deepPurple)),

          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
