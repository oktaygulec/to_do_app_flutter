import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  bool reminder;
  DateTime date;
  bool isDone;
  IconData icon;
  Color color;

  Task({
    required this.id,
    required this.title,
    required this.reminder,
    required this.date,
    required this.isDone,
    required this.icon,
    required this.color,
  });
}
