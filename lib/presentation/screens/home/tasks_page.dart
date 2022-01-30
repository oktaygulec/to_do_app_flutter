import 'package:flutter/material.dart';
import '/data/models/task.dart';
import '/service/api/task_api.dart';
import '/service/api/user_api.dart';
import '/presentation/widgets/dialogs.dart';
import '/presentation/widgets/task/task_list.dart';
import '/presentation/widgets/titlebar/list_with_title_bar.dart';

class TasksPage extends StatefulWidget {
  final Function changeIndex;
  TasksPage(this.changeIndex);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = TaskApi.tasks;
  TaskApi api = new TaskApi();

  void _onDone(task) async {
    task.isDone = !task.isDone;
    int idx = tasks.indexWhere((element) => element.id == task.id);

    // TODO: Got a problem with PUT Request

    // final isUpdated = await api.updateTask(task, UserApi.currentUser.token);
    // if (isUpdated)
    setState(() => tasks[idx] = task);
    // else
    //   Dialogs.errorDialog(context, "Error!", "Couldn't update the task...");
  }

  void _onDelete(task) async {
    final isDeleted = await api.deleteTask(
      task.id,
      UserApi.currentUser.token,
    );
    if (isDeleted)
      setState(() => tasks.remove(task));
    else
      Dialogs.errorDialog(context, "Error!", "Couldn't delete the task...");
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> _waitingTasks =
        tasks.where((task) => !task.isDone).toList();
    final List<Task> _finishedTasks =
        tasks.where((task) => task.isDone).toList();

    _waitingTasks.sort((a, b) => a.date.compareTo(b.date));
    _finishedTasks.sort((a, b) => a.date.compareTo(b.date));

    return (_waitingTasks.length + _finishedTasks.length) > 0 ||
            tasks.length > 0
        ? ListView(
            children: [
              ListWithTitleBar(
                title: "Waiting Tasks",
                showIcon: true,
                showStatusBar: true,
                icon: Icon(Icons.schedule, color: Colors.blue),
                amount: _waitingTasks.length,
                body: TaskList(
                  tasks: _waitingTasks,
                  onDone: _onDone,
                  onDelete: _onDelete,
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
                  onDone: _onDone,
                  onDelete: _onDelete,
                ),
              ),
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("There are no tasks... Let's add some!"),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ElevatedButton(
                  onPressed: () {
                    widget.changeIndex();
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          );
  }
}
