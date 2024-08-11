import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:t168/src/models/task_models.dart';

class AddTaskProvider extends ChangeNotifier {
  final List<TaskModels> _tasks = [];

  List<TaskModels> get tasks => _tasks;

  int get completed => _tasks.where((task) => task.priority == 0).length;
  int get created => _tasks.where((task) => task.priority == 1).length;
  int get canceled => _tasks.where((task) => task.priority == 2).length;

  AddTaskProvider() {
    _loadTasksFromCache();
  }

  void deleteTask(TaskModels task) {
    _tasks.remove(task);
    _saveTasksToCache();
    notifyListeners();
  }

  void addTask(TaskModels task) {
    _tasks.add(task);
    _saveTasksToCache();
    notifyListeners();
  }

  void updateTaskPriority(TaskModels task, int newPriority) {
    int index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(priority: newPriority);
      _saveTasksToCache();
      notifyListeners();
    }
  }

  void updateTask(TaskModels oldTask, TaskModels newTask) {
    int index = _tasks.indexOf(oldTask);
    if (index != -1) {
      _tasks[index] = newTask;
      _saveTasksToCache();
      notifyListeners();
    }
  }

  void removeTaskAtIndex(int index) {
    if (index >= 0 && index < _tasks.length) {
      // Update the task priority to "Canceled"
      updateTaskPriority(_tasks[index], 2);
    }
  }

  void _saveTasksToCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _tasks.map((task) => task.toJson()).toList(),
    );
    prefs.setString('tasks', encodedData);
  }

  void deleteAllData() async {
    _tasks.clear(); // Очистить список задач
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tasks'); // Удалить сохранённые задачи
    notifyListeners();
  }

  void _loadTasksFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> decodedData = jsonDecode(tasksString);
      _tasks.clear();
      _tasks.addAll(decodedData.map((json) => TaskModels.fromJson(json)));
      notifyListeners();
    }
  }
}
