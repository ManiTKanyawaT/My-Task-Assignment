import 'dart:convert';
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:flutter_task_assignment/shared/constants/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStore extends GetxController {
  final GetStorage _box;

  GetStore(this._box);

  Future<void> saveTask(List<TaskInfo> tasks) async {
    List<String> taskJsonList =
        tasks.map((task) => jsonEncode(task.toJson())).toList();

    await _box.write(PrefKey.mytask, taskJsonList);
  }

  Future<void> removeAllTasks() async {
    await _box.remove(PrefKey.mytask);
  }

  Future<List<TaskInfo>> getTasks() async {
    List<String> data = (_box.read(PrefKey.mytask) ?? []).cast<String>();

    return data.map((taskString) {
      return TaskInfo.fromJson(jsonDecode(taskString));
    }).toList();
  }

  // Future<void> removeTaskByTitle(String taskTitle) async {
  //   List<TaskInfo> tasks = await getTasks();
  //   tasks.removeWhere((task) => task.title == taskTitle);

  //   await saveTask(tasks);
  // }
}
