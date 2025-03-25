import 'dart:convert'; // For jsonDecode
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:flutter_task_assignment/shared/constants/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStore extends GetxController {
  final GetStorage _box;

  GetStore(this._box);

  // Save tasks to storage
  Future<void> saveTask(List<TaskInfo> tasks) async {
    List<String> convertTaskString =
        tasks.map((task) => jsonEncode(task.toJson())).toList();

    await _box.write(PrefKey.mytask, convertTaskString);
  }

  // Remove all tasks
  Future<void> removeTask() async {
    await _box.remove(PrefKey.mytask);
  }

  // Retrieve tasks from storage
  List<TaskInfo> getTasks() {
    List<String> data = _box.read<List<String>>(PrefKey.mytask) ?? [];

    return data.map((taskString) {
      return TaskInfo.fromJson(jsonDecode(taskString));
    }).toList();
  }

  // Remove a specific task by its title
  Future<void> removeTaskByTitle(String taskTitle) async {
    List<TaskInfo> tasks = getTasks();
    tasks.removeWhere((task) => task.title == taskTitle);
    await saveTask(tasks);
  }
}
