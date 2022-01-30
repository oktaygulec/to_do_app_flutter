import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/data/constants/icons.dart';
import '/presentation/widgets/circle_icon.dart';

class TaskItemContent extends StatelessWidget {
  final String title;
  final String date;
  final String icon;
  final String color;

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
              color: Color(int.parse(color)),
              icon: List.of(pickerIcons).firstWhere(
                  (element) => element.codePoint.toString() == icon),
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
                        color: Theme.of(context).textTheme.bodyText2?.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('dd.MM.yyyy HH:mm')
                        .format(DateTime.parse(date))
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.color
                            ?.withOpacity(.55),
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
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
