import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/widgets/circle_icon.dart';
import '/models/task.dart';

class DetailsPage extends StatelessWidget {
  final Task task;

  DetailsPage(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(task.title,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.edit, color: task.color, size: 32),
                    onPressed: () {},
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      CircleIcon(
                          color: task.color,
                          icon: task.icon,
                          margin: EdgeInsets.only(bottom: 16),
                          width: 75,
                          height: 75),
                      Text(
                        task.title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black26, thickness: .4),
                Text(
                    DateFormat('dd.MM.yyyy HH:mm').format(task.date).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87)),
                Text("Reminder: " + (task.reminder ? "ON" : "OFF")),
                Text("ID: " + (task.id.toString())),
              ],
            )),
      ),
    );
  }
}
