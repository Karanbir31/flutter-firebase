

import 'package:get/get.dart';
import 'package:my_firebase/task_list/controller/my_tasks_controller.dart';

class MyTasksBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> MyTasksController());
  }

}