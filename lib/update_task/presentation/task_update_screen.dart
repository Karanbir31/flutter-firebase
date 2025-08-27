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
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: controller.saveTask,
            icon: const Icon(Icons.done),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,

            children: [
              // Title Field
              inputTextField(
                label: "Title",
                controller: controller.titleController,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 4,
              ),

              // Description Field (expands to fill remaining space)
              Flexible(
                child: inputTextField(
                  label: "Description",
                  controller: controller.descriptionController,
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null,
                  expands: true,
                ),
              ),

              FractionallySizedBox(
                widthFactor: 0.8,
                alignment: AlignmentGeometry.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // <-- round corners
                    ),
                  ),
                  onPressed: controller.saveTask,
                  child: Text("Save"),
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
    bool expands = false,
  }) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return "Enter $label";
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hint: Text(label),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
