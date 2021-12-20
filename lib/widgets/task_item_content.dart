import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'circle_icon.dart';

class TaskItemContent extends StatelessWidget {

  final String title;
  final DateTime date;
  final IconData icon;
  final Color color;

  TaskItemContent({
    required this.title, 
    required this.date, 
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleIcon(
            color: color, 
            icon: icon, 
            margin: EdgeInsets.only(right: 16)),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('dd.MM.yyyy HH:mm').format(date).toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}