import 'package:flutter/material.dart';
import '/models/task.dart';

List<Task> allTasks = [
  Task(
      id: 0,
      title: "Task 1",
      date: DateTime.now(),
      isDone: true,
      reminder: false,
      color: Colors.orange,
      icon: Icons.star),
  Task(
      id: 1,
      title: "Task 2",
      date: DateTime.now(),
      isDone: false,
      reminder: false,
      color: Colors.red,
      icon: Icons.headset),
  Task(
      id: 2,
      title: "Task 3",
      date: DateTime.now(),
      isDone: true,
      reminder: false,
      color: Colors.green,
      icon: Icons.info),
  Task(
      id: 3,
      title: "Task 4",
      date: DateTime.now(),
      isDone: true,
      reminder: false,
      color: Colors.purple,
      icon: Icons.work),
  Task(
      id: 4,
      title: "Task 5",
      date: DateTime.now(),
      isDone: false,
      reminder: false,
      color: Colors.cyan,
      icon: Icons.pets),
  Task(
      id: 5,
      title: "Task 6",
      date: DateTime.now(),
      isDone: false,
      reminder: false,
      color: Colors.brown,
      icon: Icons.leaderboard),
];
