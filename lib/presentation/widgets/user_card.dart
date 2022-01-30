import 'package:flutter/material.dart';
import '/data/constants/styles.dart';
import '/data/models/user.dart';
import '/service/api/user_api.dart';
import '/service/local/user_storage.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.bottomBorder(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.person,
            ),
          ),
          title: Text(UserApi.currentUser.name),
          subtitle: Text(UserApi.currentUser.email),
          trailing: TextButton(
              child: Text("Log out"),
              onPressed: () {
                UserApi.currentUser = new User();
                new UserStorage().deleteUser();
                Navigator.of(context).pushReplacementNamed('/login');
              }),
        ),
      ),
    );
  }
}
