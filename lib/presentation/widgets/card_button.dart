import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  CardButton({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        child: ListTile(
          leading: Container(
            height: double.infinity,
            child: Icon(
              icon,
            ),
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
