import 'package:flutter/material.dart';
import 'package:todoapp/presentation/widgets/input_with_text.dart';
import '/data/models/user.dart';
import '/service/api/user_api.dart';
import '/service/local/user_storage.dart';
import '/presentation/widgets/dialogs.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  String _email = "", _password = "";
  bool? _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  TextFormField(
                    initialValue: '',
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: '',
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _password = val;
                      });
                    },
                  ),
                  InputWithText(
                    text: "Remember me",
                    widget: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          if (_email.isEmpty || _password.isEmpty)
                            Dialogs.errorDialog(context, "Error",
                                "Please enter your email address and password.");
                          else
                            login(
                              _email.trim(),
                              _password.trim(),
                              _rememberMe,
                              context,
                            );
                        }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/register");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

login(email, password, rememberMe, context) async {
  User user = User.newUser(email: email, password: password);
  UserApi api = new UserApi();
  final isLoggedIn = await api.login(user);

  if (isLoggedIn) {
    if (rememberMe) await new UserStorage().saveUser(UserApi.currentUser);
    Navigator.of(context).pushReplacementNamed("/home");
  } else
    Dialogs.errorDialog(
        context, "Error", "Email address or password is incorrect.");
}
