import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t168/src/app/app.dart';
import 'package:t168/src/presentation/providers/add_task_provider/add_task_provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AddTaskProvider>(
            create: (_) => AddTaskProvider()),
      ],
      child: const T168(),
    ),
  );
}
