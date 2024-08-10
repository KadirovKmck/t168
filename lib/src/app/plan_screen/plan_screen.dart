import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/app/main_screens/widgets/create_task_containner.dart';
import 'package:t168/src/app/add_task_screen/add_task_screen.dart';
import 'package:t168/src/providers/add_task_provider/add_task_provider.dart';
import 'package:t168/src/app/add_task_screen/widget/task_list_view.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // @override
  // void didChangeDependencies() {
  //   Provider.of<AddTaskProvider>(context, listen: false);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        leading: IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskScreen(),
              ),
            );
            setState(() {});
          },
        ),
        title: Text(
          'Plans',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Consumer<AddTaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.tasks;
          if (tasks.isEmpty) {
            return const CreateTaskContainner();
          } else {
            return TaskListView(tasks: tasks);
          }
        },
      ),
    );
  }
}
