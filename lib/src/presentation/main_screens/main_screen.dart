import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/presentation/add_task_screen/widget/task_list_view.dart';
import 'package:t168/src/presentation/main_screens/widgets/container_tasks.dart';
import 'package:t168/src/presentation/main_screens/widgets/create_task_containner.dart';
import 'package:t168/src/presentation/providers/add_task_provider/add_task_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool haveNoCurrentTasks = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ContainerTasks(
                count: '0',
                countColor: Color(0xFF24B621),
                subTitle: 'COMPLETED',
              ),
              ContainerTasks(
                count: '0',
                countColor: Color(0xFFFF8719),
                subTitle: 'CREATED',
              ),
              ContainerTasks(
                count: '0',
                countColor: Color(0xFFFF0000),
                subTitle: 'CANCELED',
              ),
            ],
          ),
          SizedBox(height: 2.5.h,),
          Consumer<AddTaskProvider>(
            builder: (context, taskProvider, child) {
              final tasks = taskProvider.tasks;
              if (tasks.isEmpty) {
                return const CreateTaskContainner();
              } else {
                return TaskListView(tasks: tasks);
              }
            },
          ),
        ],
      ),
    );
  }
}
