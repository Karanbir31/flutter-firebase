import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/task_list/controller/my_tasks_controller.dart';

class MyTasksScreen extends GetView<MyTasksController> {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("All Tasks"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.navigateToTaskUpdate(task: null);
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

      body: Obx(
        () => SafeArea(
          child: controller.myTasks.value.length <= 0
              ? Center(
                  child: MaterialButton(
                    onPressed: () {
                      controller.navigateToTaskUpdate(task: null);
                    },
                    child: Text("Add a task"),
                  ),
                )
              : myTasksUi(context),
        ),
      ),
    );
  }

  Widget myTasksUi(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var currTask = controller.myTasks.value[index];

        return ListTile(
          title: Text(currTask.title),
          subtitle: Text(currTask.description),

          onTap: () {
            controller.navigateToTaskDetails(task: currTask);
          },

          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          subtitleTextStyle: TextStyle(fontSize: 16),
        );
      },
      itemCount: 10,
    );
  }
}
