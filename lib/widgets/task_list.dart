import 'package:flutter/material.dart';
import '/widgets/task_item.dart';
import '/models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function onDone;
  final Function onDelete;
  final bool showDone;

  TaskList(
      {required this.tasks,
      required this.onDone,
      required this.onDelete,
      this.showDone = true});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var task in tasks)
        TaskItem(
          task: task,
          onDone: onDone,
          onDelete: onDelete,
          showDone: showDone,
        ),
    ]);
  }
}
