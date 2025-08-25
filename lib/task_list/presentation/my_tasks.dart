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
      appBar: AppBar(title: Text("All Tasks")),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.addNewTask,
        child: Icon(Icons.add),
      ),

      body: Obx(
        () => SafeArea(
          child: controller.myTasks.value.length <= 0
              ? Center(
                  child: MaterialButton(
                    onPressed: controller.addNewTask,
                    child: Text("Add a task"),
                  ),
                )
              : Center(
                  child: MaterialButton(
                    onPressed: controller.addNewTask,
                    child: Text("show tasks"),
                  ),
                ),
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

          onTap: () {},

          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          subtitleTextStyle: TextStyle(fontSize: 16),
        );
      },
      itemCount: 10,
    );
  }
}
