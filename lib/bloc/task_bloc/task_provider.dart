import 'dart:convert';

import 'package:http/http.dart';

import '../../models/task.dart';
import '../../providers/constants.dart';

class TaskProvider {
  Future<List<Task>?> fetchTasksByUserId(int userId) async {
    Response response = await get(
      Uri.parse('$apiURI/tasks/user?userId=$userId'),
    );
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      List<Task> tasks = list.map((task) => Task.fromJson(task)).toList();
      return tasks;
    }
    return null;
  }

  Future<List<Task>?> fetchTasksByListId(int listId) async {
    Response response =
        await get(Uri.parse('$apiURI/tasks/list?listId=$listId'));
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      List<Task> tasks = list.map((task) => Task.fromJson(task)).toList();
      return tasks;
    }
    return null;
  }

  Future<bool> deleteTask(int taskId) async {
    Response response = await delete(Uri.parse('$apiURI/tasks/?id=$taskId'));
    return response.statusCode == 200 ? true : false;
  }

  Future<Task?> createTask(Task task) async {
    Response response = await post(
      Uri.parse('$apiURI/tasks/'),
      body: jsonEncode(task.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 201
        ? Task.fromJson(jsonDecode(response.body))
        : null;
  }

  Future<Task?> updateTask(int taskId, Task task) async {
    Response response = await put(
      Uri.parse('$apiURI/tasks?id=$taskId'),
      body: jsonEncode(task.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200
        ? Task.fromJson(jsonDecode(response.body))
        : null;
  }

  Future<List<Task>?> fetchTasksByDate(DateTime dateTime, int userId) async {
    Response response = await get(
      Uri.parse('$apiURI/tasks/date?date=$dateTime&userId=$userId'),
    );
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      List<Task> tasks = list.map((task) => Task.fromJson(task)).toList();
      return tasks;
    }
    return null;
  }
}
