import 'package:flutter/material.dart';
import 'package:todoapp/presentation/screens/settings/theme_settings_page.dart';
import 'package:todoapp/presentation/widgets/card_button.dart';
import '/presentation/widgets/user_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserCard(),
        CardButton(
          icon: Icons.visibility,
          title: "Theme",
          subtitle: "Change your theme",
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ThemeSettingsPage()));
          },
        ),
        CardButton(
          icon: Icons.help,
          title: "Help",
          onTap: () {},
        ),
      ],
    );
  }
}
