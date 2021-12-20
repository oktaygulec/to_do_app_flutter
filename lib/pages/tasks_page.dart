import 'package:flutter/material.dart';
import '/models/task.dart';
import '/widgets/task_list.dart';
import '/widgets/list_with_title_bar.dart';

class TasksPage extends StatelessWidget {
  final List<Task> tasks;
  final Function onDone;
  final Function onDelete;

  TasksPage({
    required this.tasks,
    required this.onDone,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final List<Task> _waitingTasks =
        tasks.where((task) => !task.isDone).toList();
    final List<Task> _finishedTasks =
        tasks.where((task) => task.isDone).toList();

    _waitingTasks.sort((a, b) => a.date.compareTo(b.date));
    _finishedTasks.sort((a, b) => a.date.compareTo(b.date));

    return ListView(
      children: [
        ListWithTitleBar(
          title: "Waiting Tasks",
          showIcon: true,
          showStatusBar: true,
          icon: Icon(Icons.schedule, color: Colors.blue),
          amount: _waitingTasks.length,
          body: TaskList(
            tasks: _waitingTasks,
            onDone: onDone,
            onDelete: onDelete,
          ),
        ),
        ListWithTitleBar(
          title: "Finished Tasks",
          showIcon: true,
          showStatusBar: true,
          icon: Icon(Icons.done, color: Colors.green),
          amount: _finishedTasks.length,
          body: TaskList(
            tasks: _finishedTasks,
            onDone: onDone,
            onDelete: onDelete,
            showDone: false,
          ),
        ),
      ],
    );
  }
}
