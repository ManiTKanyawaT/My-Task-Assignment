import 'dart:convert';

class TaskApi {
 
  Future<String> fetchTasksJson() async {
    await Future.delayed(const Duration(seconds: 1)); 

    List<Map<String, dynamic>> taskList = [
      {
        'title': 'Complete Assignment',
        'description': 'Finish the assignment on Dart programming. It is an important task and needs to be completed by the end of the week.',
        'dueDate': '2025-03-30T00:00:00.000Z',
        'status': 'Incomplete',
      },
      {
        'title': 'Submit Report',
        'description': 'Submit the final report on the marketing project. Ensure all the data is correct and formatted properly.',
        'dueDate': '2025-03-25T00:00:00.000Z',
        'status': 'Completed',
      },
      {
        'title': 'Plan Team Meeting',
        'description': 'Organize and plan the upcoming team meeting for the next quarter.',
        'dueDate': '2025-04-05T00:00:00.000Z',
        'status': 'Incomplete',
      },
    ];

    return jsonEncode({'tasks': taskList});
  }




}
