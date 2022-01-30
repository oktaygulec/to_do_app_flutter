import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '/data/models/task.dart';
import '/data/constants/colors.dart';
import '/data/constants/icons.dart';
import '/service/api/task_api.dart';
import '/service/api/user_api.dart';
import '/presentation/widgets/dialogs.dart';
import '/presentation/widgets/picker/picker.dart';
import '/presentation/widgets/picker/picker_button.dart';
import '/presentation/widgets/input_with_text.dart';

class NewTaskPage extends StatefulWidget {
  final formKey;
  final Function onSave;

  const NewTaskPage({
    Key? key,
    required this.formKey,
    required this.onSave,
  }) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  Task _task = Task.newTask(
    title: "",
    reminder: false,
    date: DateTime.now().toIso8601String(),
    isDone: false,
    icon: List.of(pickerIcons)[0].codePoint.toString(),
    color: List.of(pickerColors)[0].value.toString(),
  );

  TaskApi api = new TaskApi();

  _newTask(task) async {
    task = await api.newTask(task, UserApi.currentUser.token);
    if (task.id != "") {
      setState(() => TaskApi.tasks.add(task));
      widget.onSave();
    } else {
      Dialogs.errorDialog(context, "Error", "Couldn't create a new task...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
          margin: EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
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
                    _task.title = text;
                  });
                },
              ),
              InputWithText(
                text: "Remind me",
                widget: Switch(
                  value: _task.reminder,
                  onChanged: (value) {
                    setState(() {
                      _task.reminder = value;
                    });
                  },
                ),
              ),
              InputWithText(
                text: "Pick a date",
                widget: TextButton(
                  child: Text(
                    DateFormat('dd.MM.yyyy HH:mm')
                        .format(DateTime.parse(_task.date))
                        .toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                      setState(() {
                        _task.date = date.toIso8601String();
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.tr);
                  },
                ),
              ),
              InputWithText(
                text: "Pick a color",
                widget: PickerButton(
                  selected: Selected.color,
                  color: _task.color.isEmpty
                      ? List.of(pickerColors)[0]
                      : Color(int.parse(_task.color)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Picker(
                            selected: Selected.color,
                            title: "Pick a color",
                            list: List.of(pickerColors),
                            onSelected: (MaterialColor color) {
                              setState(() {
                                _task.color = color.value.toString();
                              });
                            },
                          );
                        });
                  },
                ),
              ),
              InputWithText(
                text: "Pick an icon",
                widget: PickerButton(
                  selected: Selected.icon,
                  icon: _task.icon.isEmpty
                      ? List.of(pickerIcons)[0]
                      : List.of(pickerIcons).firstWhere((element) =>
                          element.codePoint.toString() == _task.icon),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Picker(
                            selected: Selected.icon,
                            title: "Pick an icon",
                            list: List.of(pickerIcons),
                            onSelected: (IconData icon) {
                              setState(() {
                                _task.icon = icon.codePoint.toString();
                              });
                            },
                          );
                        });
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_task.title.isEmpty) {
                      Dialogs.errorDialog(
                          context, "Warning", "You should enter the title.");
                    } else {
                      _newTask(_task);
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
