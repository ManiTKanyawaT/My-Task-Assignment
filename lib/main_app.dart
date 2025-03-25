import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/routes/app_pages.dart';
import 'package:flutter_task_assignment/shared/storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

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
      initialBinding: BindingsBuilder(() {
        Get.put(GetStore(GetStorage()));
        
      }),
    );
  }
}
