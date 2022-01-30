import 'package:flutter/material.dart';
import '/data/models/user.dart';
import '/service/local/user_storage.dart';
import '/presentation/screens/home/home_page.dart';
import '/presentation/screens/user/user_login_page.dart';
import '/presentation/screens/user/user_register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserStorage().getUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (snapshot.data == null)
          return Center(child: CircularProgressIndicator());
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return MaterialApp(
              title: "ToDoApp",
              initialRoute: user!.token.isEmpty ? '/login' : '/home',
              routes: <String, WidgetBuilder>{
                '/home': (_) => new HomePage(),
                '/login': (_) => new UserLoginPage(),
                '/register': (_) => new UserRegisterPage(),
              },
              theme: ThemeData(
                brightness: Brightness.light,
                // primarySwatch: Colors.amber,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                // primarySwatch: Colors.amber,
              ),
              themeMode: ThemeMode.dark,
            );
        }
      },
    );
  }
}
