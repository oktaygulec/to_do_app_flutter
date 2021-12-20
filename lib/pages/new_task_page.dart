import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '/widgets/picker.dart';
import '/widgets/picker_button.dart';
import '/data/colors.dart';
import '/data/icons.dart';
import '/data/tasks.dart';
import '/models/task.dart';

Task task = new Task(
    id: List.of(allTasks).length,
    title: "",
    date: DateTime.now(),
    reminder: false,
    color: Colors.red,
    icon: Icons.star,
    isDone: false);

class NewTaskPage extends StatefulWidget {
  final formKey;
  final Function newTask;
  final Function onSave;

  const NewTaskPage({
    Key? key,
    required this.formKey,
    required this.newTask,
    required this.onSave,
  }) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
          margin: EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: ListView(
            children: [
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    task.title = text;
                  });
                },
              ),
              TextButton(
                child: Text(DateFormat('dd.MM.yyyy HH:mm')
                    .format(task.date)
                    .toString()),
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    setState(() {
                      task.date = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.tr);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Remind me",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                  Switch(
                    value: task.reminder,
                    onChanged: (value) {
                      setState(() {
                        task.reminder = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pick a color",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                  PickerButton(
                    selected: Selected.color,
                    color: task.color,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Picker(
                              selected: Selected.color,
                              title: "Pick a color",
                              list: List.of(pickerColors),
                              onSelected: (color) {
                                setState(() {
                                  task.color = color;
                                });
                              },
                            );
                          });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pick an icon",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                  PickerButton(
                    selected: Selected.icon,
                    icon: task.icon,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Picker(
                              selected: Selected.icon,
                              title: "Pick an icon",
                              list: List.of(pickerIcons),
                              onSelected: (icon) {
                                setState(() {
                                  task.icon = icon;
                                });
                              },
                            );
                          });
                    },
                  )
                ],
              ),
              Container(
                height: 35,
                child: ElevatedButton(
                  child: Text("Save"),
                  onPressed: () {
                    widget.newTask(task);
                    widget.onSave();
                    task = new Task(
                        id: task.id + 1,
                        title: "",
                        date: DateTime.now(),
                        reminder: false,
                        color: Colors.red,
                        icon: Icons.star,
                        isDone: false);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
