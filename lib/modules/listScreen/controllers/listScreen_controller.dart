import 'package:flutter_task_assignment/api/task_api.dart';
import 'package:flutter_task_assignment/models/task_info.dart';
import 'package:get/get.dart';

class ListScreenController extends GetxController {
  final TaskApi _taskApi;

  // final _ex = "".obs;
  // String get ex => _ex.value;

  // final _exInfo = Rxn<ExampleInfo>();
  // ExampleInfo? get exInfo => _exInfo.value;

  final _userTask = <TaskInfo>[].obs;
  List<TaskInfo> get userTask => _userTask;

  ListScreenController(this._taskApi);

  @override
  void onInit() {
    fetchTask();
    super.onInit();
  }

  Future<void> fetchTask() async {
    final result = await _taskApi.getTasksDetails();
    setDetails(result);
  }

  void setDetails(List<TaskInfo> info) {
    _userTask.value = info;
  }

  // void setExInfo(String name, {String? remark}) {
  //   _exInfo.value = ExampleInfo(name, remark: remark);
  // }

  // void updateExInfo(String name) {
  //   _exInfo.update((val) {
  //     val?.name = name;
  //   });

  //   // _exInfo.value?.name = name;
  // }

  // void addEx(String name, {String? remark}) {
  //   _listEx.add(ExampleInfo(name, remark: remark));
  // }

  // void delEx() {
  //   _listEx.removeAt(0);
  //   // _listEx.removeWhere((element) => element.name == "test");
  // }
}
