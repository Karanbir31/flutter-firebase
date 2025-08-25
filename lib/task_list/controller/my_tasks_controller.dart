import 'package:get/get.dart';
import 'package:my_firebase/main.dart';
import 'package:my_firebase/task_list/models/task_item.dart';

class MyTasksController extends GetxController {
  RxList<TaskItem> myTasks = <TaskItem>[].obs;

  void navigateToTaskUpdate( {TaskItem? task }) {
    Get.toNamed(NavRoutes.taskUpdateRoute, arguments: {'data': task});
  }

  void navigateToTaskDetails({required TaskItem task}) {}
}
