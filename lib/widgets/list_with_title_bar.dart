import 'package:flutter/material.dart';
import 'title_bar.dart';

class ListWithTitleBar extends StatelessWidget {

  final Widget body;
  final int amount;
  final Icon icon;
  final String title;
  final bool showStatusBar;
  final bool showIcon;

  const ListWithTitleBar({ 
    Key? key, 
    required this.body, 
    required this.title, 
    required this.showStatusBar,
    required this.showIcon,
    this.icon = const Icon(Icons.schedule, color: Colors.blue), 
    this.amount = 0
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TitleBar(
            showStatusBar: showStatusBar,
            showIcon: showIcon,
            icon: icon,
            title: title,
            amount: amount
          ),
          body
        ]
    );
  }
}