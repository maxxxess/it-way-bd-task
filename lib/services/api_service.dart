import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:it_way_bd/models/task_model.dart';


class ApiService {
  final String baseUrl = 'https://67a24d7b409de5ed5255020b.mockapi.io/tasks';//Dummy api link to fetch and add data .

  // Fetch tasks from the custom MockAPI
  Future<List<Task>> fetchTasks() async {
  final response = await http.get(Uri.parse(baseUrl));
  //print('API Response: ${response.body}'); // Log the response

  if (response.statusCode == 200) {
    List<Task> tasks = (json.decode(response.body) as List)
        .map((data) => Task.fromJson(data))
        .toList();
    return tasks;
  } else {
    throw Exception('Failed to load tasks');
  }
}


  // Add a new task to the custom MockAPI
  Future<Task> addTask(String title) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'completed': false,
      }),
    );

    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }

  // Mark a task as completed in the custom MockAPI
  Future<void> toggleTaskCompletion(int id, bool isCompleted) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'completed': isCompleted}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }
}
