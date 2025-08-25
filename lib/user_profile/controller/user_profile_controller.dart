import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_firebase/main.dart';

class UserProfileController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Observables for UI
  RxString userImageUrl = "".obs;
  RxString userName = "".obs;
  RxString userEmail = "".obs;

  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    loadUserData();
  }

  void loadUserData() {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      _navigateToAuthScreen();
    } else {
      // Set user details
      userName.value = user.displayName ?? "No name available";
      userEmail.value = user.email ?? "No email available";
      userImageUrl.value = user.photoURL ?? "";

      isLoading.value = false;
    }
  }

  Future<void> onPressSignOut() async {
    try {
      await firebaseAuth.signOut();
      isLoading.value = true;
      _navigateToAuthScreen();
    } catch (e) {
      Get.snackbar("Error", "Failed to sign out: $e");
    }
  }

  void _navigateToAuthScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.offAllNamed(NavRoutes.authenticationRoute);
    });
  }
}
