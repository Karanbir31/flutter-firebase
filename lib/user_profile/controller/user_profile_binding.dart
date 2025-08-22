import 'package:get/get.dart';
import 'package:my_firebase/user_profile/controller/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController());
  }
}
