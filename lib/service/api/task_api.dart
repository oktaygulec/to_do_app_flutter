import 'dart:convert';
import '/data/models/task.dart';
import '/service/abstracts/api_manager.dart';

class TaskApi extends ApiManager {
  static List<Task> tasks = [];

  Future<List<Task>> getTasks(String token) async {
    final response = await request(
      todoURI,
      getHeadersWithToken,
      MethodType.GET,
    );

    final isOK = checkRequest(response,
        successMessage: "Got all tasks",
        errorMessage: "getTasks error. Status code: ${response.statusCode}");

    if (isOK) {
      final body = json.decode(response.body);
      List<Task> tasks = [];

      for (var item in body) {
        tasks.add(Task.fromJson(item));
      }

      return tasks;
    }

    return [];
  }

  Future<Task> newTask(Task task, String token) async {
    final response = await request(
      todoURI,
      getHeadersWithToken,
      MethodType.POST,
      body: task.toJson(),
    );

    final isOK = checkRequest(
      response,
      successMessage: "Added new task.",
      errorMessage: "newTask error! Status code: ${response.statusCode}",
    );

    if (isOK) {
      final body = json.decode(response.body);
      task = Task.fromJson(body);
      return task;
    }
    return new Task();
  }

  Future<bool> deleteTask(String id, String token) async {
    final response = await request(
      todoURI + "/$id",
      getHeadersWithToken,
      MethodType.DELETE,
    );

    return checkRequest(
      response,
      successMessage: "$id deleted.",
      errorMessage: "deleteTask error! Status code: ${response.statusCode}",
    );
  }

  Future<bool> updateTask(Task task, String token) async {
    final response = await request(
      todoURI + "/${task.id}",
      getHeadersWithToken,
      MethodType.PUT,
      body: task.toJson(),
    );

    return checkRequest(
      response,
      successMessage: "${task.title} updated.",
      errorMessage:
          "TASK API (updateTask) ERROR! Status code: ${response.statusCode}",
    );
  }
}
