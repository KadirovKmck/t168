import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/models/task_models.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:t168/src/presentation/add_task_screen/widget/edit_task.dart';

class TaskListView extends StatelessWidget {
  final List<TaskModels> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    // Сортировка задач по приоритету
    final sortedTasks = List<TaskModels>.from(tasks)
      ..sort((a, b) => b.priority.compareTo(a.priority));

    return SizedBox(
      height: 73.h,
      child: ListView.builder(
        itemCount: sortedTasks.length,
        itemBuilder: (context, index) {
          final task = sortedTasks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Slidable(
              groupTag: tasks,
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTask(
                            task: task,
                          ),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.abc,
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.abc,
                  ),
                ],
              ),
              child: Container(
                width: double.infinity,
                height: 25.h,
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.05),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.5.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      task.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15.5.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                            'assets/icons/vector${task.priority + 1}.svg'),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.time,
                                color: Colors.white),
                            SizedBox(width: 1.5.w),
                            Text(
                              task.date,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
