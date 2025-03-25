import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/modules/listScreen/bindings/listScreen_binding.dart';
import 'package:flutter_task_assignment/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Assignment',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: Routes.listScreenView,
      builder: EasyLoading.init(),
      initialBinding: BindingsBuilder(() {}),
    );
  }
}
