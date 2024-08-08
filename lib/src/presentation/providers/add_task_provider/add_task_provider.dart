import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:t168/src/models/task_models.dart';

class AddTaskProvider extends ChangeNotifier {
  final List<TaskModels> _tasks = [];

  List<TaskModels> get tasks => _tasks;

  AddTaskProvider() {
    _loadTasksFromCache();
  }

  void addTask(TaskModels task) {
    _tasks.add(task);
    _saveTasksToCache();
    notifyListeners();
  }

  void _saveTasksToCache() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _tasks.map((task) => task.toJson()).toList(),
    );
    prefs.setString('tasks', encodedData);
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
