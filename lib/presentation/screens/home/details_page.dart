import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/data/constants/icons.dart';
import '/data/models/task.dart';
import '/presentation/widgets/circle_icon.dart';

class DetailsPage extends StatelessWidget {
  final Task task;

  DetailsPage(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleIcon(
                        color: Color(int.parse(task.color)),
                        icon: List.of(pickerIcons).firstWhere((element) =>
                            element.codePoint.toString() == task.icon),
                        margin: EdgeInsets.only(bottom: 16),
                        width: 75,
                        height: 75,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 32,
                          height: 32,
                          color: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(thickness: .4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy HH:mm')
                        .format(DateTime.parse(task.date))
                        .toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text("Reminder: " + (task.reminder ? "ON" : "OFF")),
                  Text("ID: " + (task.id.toString())),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  // TODO: Edit task screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
