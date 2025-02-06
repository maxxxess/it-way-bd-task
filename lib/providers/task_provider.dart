import 'package:flutter/material.dart';
import 'package:it_way_bd/models/task_model.dart';
import 'package:it_way_bd/services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _allTasks = [];
  final ApiService _apiService = ApiService();

  List<Task> get tasks => _tasks;

  // Fetch tasks
  Future<void> fetchTasks() async {
    try {
      _tasks = await _apiService.fetchTasks();
      _allTasks = List.from(_tasks); // Save all tasks to use for searching
      notifyListeners();
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  // Add a task
  Future<void> addTask(String title) async {
    try {
      Task newTask = await _apiService.addTask(title);
      _tasks.add(newTask);
      _allTasks.add(newTask); // Keep the task in the full list
      notifyListeners();
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }

  // Mark task as completed
  Future<void> toggleTaskCompletion(int id, bool isCompleted) async {
    try {
      await _apiService.toggleTaskCompletion(id, isCompleted);
      _tasks.firstWhere((task) => task.id == id).completed = isCompleted;
      notifyListeners();
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }

  // Search tasks by title
  void searchTasks(String query) {
    if (query.isEmpty) {
      _tasks = List.from(_allTasks); // Reset to all tasks
    } else {
      _tasks = _allTasks
          .where(
              (task) => task.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
