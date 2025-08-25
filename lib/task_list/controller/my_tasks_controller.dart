import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_firebase/main.dart';
import 'package:my_firebase/task_list/models/task_item.dart';

class MyTasksController extends GetxController {
  final _tag = "MyTasksController";

  final firebaseApp = Firebase.app();
  late final firebaseDatabase = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL:
        "https://clgproject-9bcab-default-rtdb.asia-southeast1.firebasedatabase.app/",
  );

  final String userAuthId = FirebaseAuth.instance.currentUser?.uid ?? "user_id";
  late DatabaseReference dbReference;

  RxList<TaskItem> myTasks = <TaskItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    dbReference = firebaseDatabase.ref("tasks").child(userAuthId);
  }

  @override
  void onReady() {
    super.onReady();
    // automatically load tasks on init
    _readAllTasks();
  }

  /// Navigate to add/edit task
  Future navigateToTaskUpdate({TaskItem? task}) async {
    var result = await Get.toNamed(
      NavRoutes.taskUpdateRoute,
      arguments: {'data': task},
    );
    _readAllTasks();
  }

  /// Navigate to task details
  void navigateToTaskDetails({required TaskItem task}) {
    // implement later
    _readAllTasks();
  }

  /// Read all tasks from Firebase once
  Future<void> _readAllTasks() async {
    final snapshot = await dbReference.get();

    if (!snapshot.exists) {
      debugPrint("$_tag -> No tasks found");
      myTasks.clear();
      return;
    }

    final data = snapshot.value as Map<dynamic, dynamic>;
    final taskList = <TaskItem>[];

    data.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        taskList.add(TaskItem.fromJson(Map<String, dynamic>.from(value)));
      }
    });

    myTasks.assignAll(taskList);
    debugPrint("$_tag -> Loaded ${myTasks.length} tasks");
  }

  /// Listen for realtime changes (optional)
  void listenToTasks() {
    dbReference.onValue.listen((event) {
      if (event.snapshot.value == null) {
        myTasks.clear();
        return;
      }

      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final taskList = <TaskItem>[];

      data.forEach((key, value) {
        if (value is Map<dynamic, dynamic>) {
          taskList.add(TaskItem.fromJson(Map<String, dynamic>.from(value)));
        }
      });

      myTasks.assignAll(taskList);
      debugPrint("$_tag -> Updated tasks list (${myTasks.length})");
    });
  }

  Future<void> deleteTask({required String taskId}) async {
    try {
      await dbReference.child(taskId).remove();
      _readAllTasks();
      debugPrint("$_tag -> Task $taskId deleted successfully");
    } catch (e) {
      debugPrint("$_tag -> Failed to delete task $taskId: $e");
    }
  }


}
