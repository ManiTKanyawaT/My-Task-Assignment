class TaskInfo {
  final String title;
  final String description;
  final DateTime dueDate;
  final String status; 

  TaskInfo({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) {
    return TaskInfo(
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'status': status,
    };
  }
}