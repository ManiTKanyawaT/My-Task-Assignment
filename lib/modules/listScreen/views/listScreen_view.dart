import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:flutter_task_assignment/modules/listScreen/controllers/listScreen_controller.dart';
import 'package:flutter_task_assignment/modules/listScreen/views/widgets/TaskDialogBottomSheet.dart';
import 'package:get/get.dart';

class ListScreenView extends StatefulWidget {
  const ListScreenView({super.key});

  @override
  State<ListScreenView> createState() => _ListScreenViewState();
}

class _ListScreenViewState extends State<ListScreenView> {
  final controller = Get.find<ListScreenController>();

  void showTaskDialog({required bool isEdit, TaskInfo? task}) {
    controller.resetErrors();
    controller.updateTextFieldsFromModel(task);

    if (!isEdit) {
      controller.formModels.titleController.clear();
      controller.formModels.decsController.clear();
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TaskDialogBottomSheet(
          isEdit: isEdit,
          task: task,
          onSave: (newTask) {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              showTaskDialog(isEdit: false);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.refreshPage(),
        child: SingleChildScrollView(
          child: Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.userTask.length,
              itemBuilder: (context, index) {
                final task = controller.userTask[index];
                final isDone = task.status == "Completed";
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDone ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task.status,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            showTaskDialog(isEdit: true, task: task);
                          },
                          splashRadius: 20,
                        ),
                        if (!isDone) ...[
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {},
                            splashRadius: 20,
                          ),
                        ]
                      ],
                    ),
                    onTap: () {},
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
