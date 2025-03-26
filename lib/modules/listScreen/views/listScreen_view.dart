import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:flutter_task_assignment/modules/listScreen/controllers/listScreen_controller.dart';
import 'package:flutter_task_assignment/modules/listScreen/enums/sortType.dart';
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

    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return TaskDialogBottomSheet(
          isEdit: isEdit,
          task: task,
          onSave: (newTask) {
            controller.saveTask(newTask, existingTask: task);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Task List"),
            actions: [
              IconButton(
                icon: Obx(() => Icon(
                      Icons.date_range,
                      color: controller.currentSort == SortTypeEnum.byDate
                          ? Colors.blue
                          : Colors.grey,
                    )),
                onPressed: controller.onDateSortPressed,
              ),
              IconButton(
                icon: Obx(() => Icon(
                      Icons.sort,
                      color: controller.currentSort == SortTypeEnum.byStatus
                          ? Colors.blue
                          : Colors.grey,
                    )),
                onPressed: controller.onStatusSortPressed,
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
            child: Obx(() {
              return ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.userTask.length,
                itemBuilder: (context, index) {
                  final task = controller.userTask[index];
                  final isDone = task.status == "Completed";
                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.redAccent,
                        child: const Icon(Icons.delete_forever,
                            color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        controller.deleteTask(task);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Task deleted'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                controller.restoreTask(task, index);
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isDone ? Icons.check_circle : Icons.cancel,
                                  color: isDone ? Colors.green : Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      showTaskDialog(isEdit: true, task: task),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.formatDate(task.dueDate),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              task.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.shade400,
                            )
                          ],
                        ),
                      ));
                },
              );
            }),
          )),
    );
  }
}
