import 'package:flutter_task_assignment/modules/listScreen/bindings/listScreen_binding.dart';
import 'package:flutter_task_assignment/modules/listScreen/views/listScreen_view.dart';
import 'package:get/get.dart';

part './app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.listScreenView,
      page: () => const ListScreenView(),
      binding: ListScreenBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
