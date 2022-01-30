import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '/data/constants/styles.dart';
import '/data/models/task.dart';
import '/presentation/screens/home/details_page.dart';
import './task_item_content.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function onDone;
  final Function onDelete;

  TaskItem({
    required this.task,
    required this.onDone,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Slidable(
        key: ValueKey(task.id.toString()),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            onDone(task);
          }),
          children: [
            task.isDone
                ? SlidableAction(
                    onPressed: (context) {
                      onDone(task);
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.restore,
                    label: 'Undone',
                  )
                : SlidableAction(
                    onPressed: (context) {
                      onDone(task);
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.done,
                    label: 'Done',
                  )
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(task);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: TextButton(
          style: Styles.taskButtonStyle,
          child: TaskItemContent(
            date: task.date,
            title: task.title,
            icon: task.icon,
            color: task.color,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage(task)),
            );
          },
        ),
      ),
    );
  }
}
