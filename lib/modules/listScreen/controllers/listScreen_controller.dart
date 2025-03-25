import 'package:flutter_task_assignment/api/task_api.dart';
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:flutter_task_assignment/modules/listScreen/views/configs/form_model.dart';
import 'package:flutter_task_assignment/shared/storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListScreenController extends GetxController {
  final TaskApi _taskApi;

  final GetStore getStore = Get.find<GetStore>();

  final _userTask = <TaskInfo>[].obs;
  List<TaskInfo> get userTask => _userTask;

  // Form field controllers
  late FormModel formModels;

  var titleError = Rx<String?>(null);
  var statusError = Rx<String?>(null);
  var descriptionError = Rx<String?>(null);
  var dueDateError = Rx<String?>(null);

  ListScreenController(this._taskApi);

  @override
  void onInit() async {
    firstTimeFetchOnly();
    formModels = FormModel.create();

    super.onInit();
  }

  Future<void> firstTimeFetchOnly() async {
    List<TaskInfo> tasks = await getStore.getTasks();

    if (tasks.isEmpty) {
      await fetchTask();
    } else {
      setTaskDetails();
    }
  }

  Future<void> fetchTask() async {
    final result = await _taskApi.getTasksDetails();
    await saveTaskToStore(result);
  }

  Future<void> saveTaskToStore(List<TaskInfo> result) async {
    await getStore.saveTask(result);
    setTaskDetails();
  }

  void setTaskDetails() async {
    _userTask.value = await getStore.getTasks();
  }

  void refreshPage() {
    firstTimeFetchOnly();
  }

  void updateTextFieldsFromModel(TaskInfo? data) {
    formModels.titleController.text = data?.title ?? '';
    formModels.decsController.text = data?.description ?? '';
    formModels.statusController.text = data?.status ?? 'Incomplete';
    formModels.dueDateController.text = formatDate(data?.dueDate);
  }

  void clearTextFields(TaskInfo? data) {
    formModels.clear();
  }

  String? validateField(String value, String type) {
    switch (type.toLowerCase()) {
      case 'title':
        return value.isEmpty
            ? 'Please enter a title'
            : value.length > 50
                ? 'Title cannot exceed 50 characters'
                : null;

      case 'status':
        return value.isEmpty ? 'Please select a status' : null;

      case 'duedate':
        return value.isEmpty ? 'Please enter a due date' : null;

      default:
        return null;
    }
  }

  void resetErrors() {
    titleError.value = null;
    statusError.value = null;
    descriptionError.value = null;
    dueDateError.value = null;
  }

  String formatDate(String? isoDate) {
    DateTime dateTime =
        DateTime.parse(isoDate ?? DateTime.now().toIso8601String());
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  void saveTask(TaskInfo task, {TaskInfo? existingTask}) {
    if (existingTask != null) {
      final index = _userTask.indexOf(existingTask);
      if (index != -1) {
        _userTask[index] = task;
      }
    } else {
      _userTask.add(task);
    }
    saveTaskToStore(_userTask);
  }

  void deleteTask(TaskInfo taskToDelete) {
    _userTask.remove(taskToDelete);
    saveTaskToStore(_userTask);
  }

  @override
  void onClose() {
    formModels.dispose();
    super.onClose();
  }
}
