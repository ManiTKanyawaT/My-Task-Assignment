import 'package:flutter_task_assignment/modules/listScreen/controllers/listScreen_controller.dart';
import 'package:get/get.dart';


class ListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ListScreenController>(ListScreenController());
  }
}
