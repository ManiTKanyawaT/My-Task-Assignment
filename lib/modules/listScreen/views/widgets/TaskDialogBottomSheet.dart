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

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 26,
        right: 26,
        top: 26,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? "Edit Task" : "Add Task",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildTitleField(controller),
            const SizedBox(height: 10),
            _buildStatusDropdown(controller),
            const SizedBox(height: 10),
            _buildDescriptionField(controller),
            const SizedBox(height: 10),
            _buildDueDateField(context, controller),
            const SizedBox(height: 20),
            _buildActionButtons(context, controller),
             const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField(ListScreenController controller) {
    return Obx(() {
      return TextFormField(
        controller: controller.formModels.titleController,
        maxLines: 2,
        minLines: 1,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: 'Title *',
          errorText: controller.titleError.value,
        ),
        onChanged: (value) {
          controller.titleError.value =
              controller.validateField(value, 'title');
        },
      );
    });
  }

  Widget _buildStatusDropdown(ListScreenController controller) {
    return Obx(() {
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
        items: ['Incomplete', 'Completed']
            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
            .toList(),
      );
    });
  }

  Widget _buildDescriptionField(ListScreenController controller) {
    return Obx(() {
      return TextFormField(
        controller: controller.formModels.decsController,
        maxLines: 5,
        minLines: 1,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: 'Description',
          errorText: controller.descriptionError.value,
        ),
        onChanged: (value) {
          controller.descriptionError.value =
              controller.validateField(value, 'description');
        },
      );
    });
  }

  Widget _buildDueDateField(
      BuildContext context, ListScreenController controller) {
    return Obx(() {
      return TextFormField(
        controller: controller.formModels.dueDateController,
        readOnly: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: 'Due Date *',
          errorText: controller.dueDateError.value,
        ),
        onTap: () async {
          final initialDate = DateTime.tryParse(
                controller.formModels.dueDateController.text,
              ) ??
              DateTime.now();
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
          );
          if (pickedDate != null) {
            controller.formModels.dueDateController.text =
                pickedDate.toLocal().toIso8601String().split('T').first;

            controller.dueDateError.value = controller.validateField(
              controller.formModels.dueDateController.text,
              'duedate',
            );
          }
        },
      );
    });
  }

  Widget _buildActionButtons(
      BuildContext context, ListScreenController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (controller.isFormValid()) {
              FocusScope.of(context).unfocus();
              final task = controller.createTaskInfo();
              onSave(task);
              Navigator.of(context).pop();
            } else {
              controller.validateAllFields();
            }
          },
          child: Text(isEdit ? "Save" : "Add"),
        ),
      ],
    );
  }
}
