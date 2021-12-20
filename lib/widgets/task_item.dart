import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '/models/task.dart';
import 'task_item_content.dart';
import '/pages/details_page.dart';
import '/styles.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function onDone;
  final Function onDelete;
  final bool showDone;

  TaskItem(
      {required this.task,
      required this.onDone,
      required this.onDelete,
      this.showDone = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.20,
        key: new Key(task.id.toString()),
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          onDismissed: (type) {
            type == SlideActionType.primary ? onDone(task.id) : onDelete(task);
          },
        ),
        child: TextButton(
          style: Styles.taskButtonStyle,
          child: TaskItemContent(
              date: task.date,
              title: task.title,
              icon: task.icon,
              color: task.color),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage(task)),
            );
          },
        ),
        actions: [
          if (showDone)
            IconSlideAction(
              caption: 'Done',
              color: Colors.green,
              icon: Icons.done,
              onTap: () {
                onDone(task.id);
              },
            ),
        ],
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              onDelete(task);
            },
          ),
        ],
      ),
    );
  }
}
