import 'package:get/get.dart';
import 'package:my_firebase/update_task/controller/task_update_controller.dart';

class TaskUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskUpdateController());
  }
}
