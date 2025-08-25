import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase/update_task/controller/task_update_controller.dart';

class TaskUpdateScreen extends GetView<TaskUpdateController> {
  const TaskUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final task = arguments['data'];

    if (task != null) {
      controller.taskToUpdate(task: task);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: controller.saveTask, icon: Icon(Icons.done)),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              inputTextField(
                label: "Title",
                controller: controller.titleController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 4,
              ),

              Flexible(
                flex: 1,
                child: inputTextField(
                  label: "Description",
                  controller: controller.descriptionController,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    int? maxLines,
    int? minLines,
  }) {
    return TextFormField(
      controller: controller,

      minLines: minLines,
      maxLines: maxLines,

      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return "Enter $label";
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(),
      ),
    );
  }
}
