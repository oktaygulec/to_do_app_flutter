import 'package:flutter/material.dart';
import '/data/models/task.dart';
import './task_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function onDone;
  final Function onDelete;

  TaskList({required this.tasks, required this.onDone, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var task in tasks)
        TaskItem(
          task: task,
          onDone: onDone,
          onDelete: onDelete,
        ),
    ]);
  }
}
