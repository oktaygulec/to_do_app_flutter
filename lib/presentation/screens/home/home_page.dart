import 'package:flutter/material.dart';
import '/data/models/task.dart';
import '/service/api/task_api.dart';
import '/service/api/user_api.dart';
import '/presentation/screens/home/new_task_page.dart';
import '/presentation/screens/home/settings_page.dart';
import '/presentation/screens/home/tasks_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> tabs;
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  final TaskApi api = new TaskApi();

  @override
  void initState() {
    tabs = [
      FutureBuilder<List<Task>>(
        future: api.getTasks(UserApi.currentUser.token),
        builder: (context, snapshot) {
          final _tasks = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Couldn't get the data..."),
                );
              } else {
                // set global tasks to that coming from api's data
                TaskApi.tasks = _tasks!;

                return TasksPage(() {
                  setState(() => _currentIndex = 1);
                });
              }
          }
        },
      ),
      NewTaskPage(
        formKey: _formKey,
        onSave: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
      SettingsPage()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        title: Text(
          _currentIndex == 0
              ? "Home"
              : _currentIndex == 1
                  ? "New Task"
                  : "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
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
    );
  }
}
