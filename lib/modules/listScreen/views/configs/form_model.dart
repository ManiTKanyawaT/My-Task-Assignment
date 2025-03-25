import 'package:flutter/material.dart';

class FormModel {
  final TextEditingController titleController;
  final TextEditingController statusController;
  final TextEditingController decsController;
  final TextEditingController dueDateController;

  FormModel({
    required this.titleController,
    required this.statusController,
    required this.decsController,
    required this.dueDateController,
  });

  factory FormModel.create() {
    return FormModel(
      titleController: TextEditingController(),
      statusController: TextEditingController(),
      decsController: TextEditingController(),
      dueDateController: TextEditingController(),
    );
  }

  void dispose() {
    titleController.dispose();
    statusController.dispose();
    decsController.dispose();
    dueDateController.dispose();
  }

  void clear() {
    titleController.clear();
    statusController.clear();
    decsController.clear();
    dueDateController.clear();
  }
}
