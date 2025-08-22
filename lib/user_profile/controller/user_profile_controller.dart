import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_firebase/main.dart';

class UserProfileController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  RxBool isLoading = true.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    if (firebaseAuth.currentUser == null) {
      _navigateToAuthScreen();
    } else {
      isLoading.value = false;
    }
  }

  void onPressSignOut() {
    firebaseAuth.signOut();
    isLoading.value = true;
    _navigateToAuthScreen();
  }

  void _navigateToAuthScreen() {
    Future.delayed(Duration(seconds: 2), () {
      Get.toNamed(NavRoutes.authenticationRoute);
    });
  }
}
