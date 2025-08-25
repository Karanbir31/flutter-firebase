import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_firebase/task_list/models/task_item.dart';

class TaskUpdateController extends GetxController {
  TaskItem? taskItem;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final firebaseApp = Firebase.app();
  late final firebaseDatabase = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL:
        "https://clgproject-9bcab-default-rtdb.asia-southeast1.firebasedatabase.app/",
  );

  final String userAuthId = FirebaseAuth.instance.currentUser?.uid ?? "user_id";
  late DatabaseReference dbReference;

  @override
  void onInit() {
    super.onInit();
    dbReference = firebaseDatabase.ref("tasks").child(userAuthId);
  }

  /// Public: Save (decides add vs update)
  Future<void> saveTask() async {
    if (taskItem == null) {
      await _addNewTask();
    } else {
      await _updateTask();
    }

    Get.back(result: "OK");
  }

  /// Private: Add new task
  Future<void> _addNewTask() async {
    String newTaskKey = dbReference.push().key ?? "id";

    TaskItem newTask = TaskItem(
      id: newTaskKey,
      title: titleController.text,
      description: descriptionController.text,
    );

    await dbReference.child(newTaskKey).set(newTask.toJson());
  }

  /// Prepare task for update (populate text fields & keep reference)
  void taskToUpdate({required TaskItem task}) {
    taskItem = task;
    titleController.text = task.title;
    descriptionController.text = task.description;
  }

  /// Private: Update existing task
  Future<void> _updateTask() async {
    if (taskItem == null) return;

    TaskItem updatedTask = taskItem!.copyWith(
      title: titleController.text,
      description: descriptionController.text,
    );

    await dbReference.child(updatedTask.id).update(updatedTask.toJson());
  }
}
