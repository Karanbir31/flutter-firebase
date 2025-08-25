import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/task_list/controller/my_tasks_controller.dart';

class MyTasksScreen extends GetView<MyTasksController> {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
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

      body: Obx(() {
        if (controller.myTasks.isEmpty) {
          return const Center(child: Text("No tasks found"));
        }

        return ListView.builder(
          itemCount: controller.myTasks.length,
          itemBuilder: (context, index) {
            final task = controller.myTasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: IconButton(
                onPressed: () {
                  controller.deleteTask(taskId: task.id);
                },
                icon: Icon(Icons.delete),
              ),
              onTap: () => controller.navigateToTaskUpdate(task: task),
            );
          },
        );
      }),
    );
  }
}
