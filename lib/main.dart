import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/main_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MainApp()); 
}
