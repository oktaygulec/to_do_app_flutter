import 'package:flutter/material.dart';
import '/data/models/user.dart';
import '/service/api/user_api.dart';
import '/presentation/widgets/dialogs.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  String _name = "", _email = "", _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => {Navigator.pop(context)},
              ),
            ),
            Center(
              child: Text(
                "Register",
                style: TextStyle(fontSize: 36),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  TextFormField(
                    initialValue: '',
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
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
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          register(_name.trim(), _email.trim(),
                              _password.trim(), context);
                        }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => {Navigator.pop(context)},
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

register(name, email, password, context) async {
  if (!inputControl(context, name.trim(), email.trim(), password.trim()))
    return;

  UserApi api = new UserApi();
  bool isUserRegistered = await api.isUser(email);

  if (isUserRegistered)
    Dialogs.errorDialog(context, "Error", "This email is already registered.");
  else {
    await api.register(User.newUser(
      name: name,
      email: email,
      password: password,
    ));

    Navigator.pop(context); // TODO: check this
    Dialogs.errorDialog(context, "Success", "Successfully registered.");
  }
}

inputControl(context, name, email, password) {
  // TODO: Add @ control
  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    Dialogs.errorDialog(context, "Error",
        "Please enter your name, email address and password.");
    return false;
  } else if (name.length < 2) {
    Dialogs.errorDialog(
        context, "Error", "Your name should be minimum 2 characters.");
    return false;
  } else if (email.length < 8) {
    Dialogs.errorDialog(
        context, "Error", "Your email should be minimum 8 characters.");
    return false;
  } else if (password.length < 10) {
    Dialogs.errorDialog(
        context, "Error", "Your password should be minimum 10 characters.");
    return false;
  }
  return true;
}
