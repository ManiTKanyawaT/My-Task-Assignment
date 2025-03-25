import 'package:flutter/material.dart';
import 'package:flutter_task_assignment/modules/listScreen/controllers/listScreen_controller.dart';
import 'package:get/get.dart';

class ListScreenView extends StatefulWidget {
  const ListScreenView({super.key});

  @override
  State<ListScreenView> createState() => _ListScreenViewState();
}

class _ListScreenViewState extends State<ListScreenView> {
  final controller = Get.find<ListScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task List"),
          actions: [
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                // Handle sorting logic
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async => controller.refreshPage(),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.userTask.length,
            itemBuilder: (context, index) {
              final task = controller.userTask[index];
              final isDone = task.status == "Completed";
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  title: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // subtitle: Padding(
                  //   padding: const EdgeInsets.only(top: 4),
                  //   child: Text(
                  //     task.description,
                  //     style:
                  //         const TextStyle(fontSize: 14, color: Colors.black54),
                  //   ),
                  // ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDone ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          task.status,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (!isDone) ...[
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {},
                          splashRadius: 20,
                        ),
                      ]
                    ],
                  ),
                  onTap: () {
                    // Navigate to task details or editing screen
                  },
                ),
              );
            },
          ),
        ));
  }
}
