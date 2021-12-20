import 'package:flutter/material.dart';
import '/pages/new_task_page.dart';
import '/pages/settings_page.dart';
import '/pages/tasks_page.dart';
import '/data/tasks.dart';
import '/models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> tasks = List.of(allTasks);
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;

  void _newTask(task) {
    setState(() => tasks.add(task));
  }

  void _onDone(id) {
    setState(() => tasks[id].isDone = !tasks[id].isDone);
  }

  void _onDelete(task) {
    setState(() => tasks.remove(task));
  }

  @override
  Widget build(BuildContext context) {
    var tabs = [
      TasksPage(
        tasks: tasks,
        onDone: _onDone,
        onDelete: _onDelete,
      ),
      NewTaskPage(
        formKey: _formKey,
        newTask: _newTask,
        onSave: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
      SettingsPage()
    ];

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 75,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          title: Text(
              _currentIndex == 0
                  ? "Home"
                  : _currentIndex == 1
                      ? "New Task"
                      : "Settings",
              style: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w600)),
        ),
        body: Container(child: tabs[_currentIndex], color: Colors.white),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black87.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'New Task',
              icon: Icon(Icons.add),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
