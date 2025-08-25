import 'package:get/get.dart';
import 'package:my_firebase/task_details/controller/task_details_controller.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskDetailsController());
  }
}
