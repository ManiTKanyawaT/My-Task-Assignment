import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:flutter_task_assignment/modules/listScreen/controllers/listScreen_controller.dart';
import 'package:get/get.dart';

class TaskDialogBottomSheet extends StatelessWidget {
  final bool isEdit;
  final TaskInfo? task;
  final Function(TaskInfo) onSave;

  const TaskDialogBottomSheet({
    super.key,
    required this.isEdit,
    this.task,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ListScreenController>();

    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(26.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEdit ? "Edit Task" : "Add Task",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Obx(() {
                  return TextFormField(
                    controller: controller.formModels.titleController,
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Title *',
                      errorText: controller.titleError.value,
                    ),
                    onChanged: (value) {
                      controller.titleError.value =
                          controller.validateField(value, 'title');
                    },
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.formModels.statusController.value.text,
                    decoration: InputDecoration(
                      labelText: 'Status *',
                      errorText: controller.statusError.value,
                    ),
                    onChanged: (newValue) {
                      controller.formModels.statusController.text = newValue!;
                      controller.statusError.value =
                          controller.validateField(newValue, 'status');
                    },
                    items: <String>['Incomplete', 'Completed']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return TextFormField(
                    controller: controller.formModels.decsController,
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Description *',
                      errorText: controller.descriptionError.value,
                    ),
                    onChanged: (value) {
                      controller.descriptionError.value =
                          controller.validateField(value, 'description');
                    },
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return TextFormField(
                    controller: controller.formModels.dueDateController,
                    decoration: InputDecoration(
                      labelText: 'Due Date *',
                      errorText: controller.dueDateError.value,
                    ),
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(
                            controller.formModels.dueDateController.text),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                      );

                      if (pickedDate != null && pickedDate != DateTime.now()) {
                        controller.formModels.dueDateController.text =
                            '${pickedDate.toLocal()}'.split(' ')[0];

                        controller.dueDateError.value =
                            controller.validateField(
                                controller.formModels.dueDateController.text,
                                'duedate');
                      }
                    },
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller
                                .formModels.titleController.text.isNotEmpty &&
                            controller
                                .formModels.statusController.text.isNotEmpty &&
                            controller
                                .formModels.dueDateController.text.isNotEmpty) {
                          final task = TaskInfo(
                            title: controller.formModels.titleController.text,
                            status: controller.formModels.statusController.text,
                            description:
                                controller.formModels.decsController.text,
                            dueDate:
                                controller.formModels.dueDateController.text,
                          );
                          onSave(task);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(isEdit ? "Save" : "Add"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
