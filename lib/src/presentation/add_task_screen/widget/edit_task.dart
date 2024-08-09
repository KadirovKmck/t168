import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/models/task_models.dart';
import 'package:t168/src/presentation/providers/add_task_provider/add_task_provider.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});
  final TaskModels task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool isEdit = false;

  void _deleteTask() {
    Provider.of<AddTaskProvider>(context, listen: false)
        .deleteTask(widget.task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        leading: const SizedBox(),
        title: Text(
          'TASK',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 17.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Container(
            height: 80.h,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    EditContainerTasks(
                      onTap: () {
                        if (isEdit) {
                          final updatedTask = TaskModels(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: widget.task.date,
                            priority: widget.task.priority,
                          );
                          Provider.of<AddTaskProvider>(context, listen: false)
                              .updateTask(widget.task, updatedTask);
                          widget.task.title = titleController.text;
                          widget.task.description = descriptionController.text;
                          setState(() {
                            isEdit = false;
                          });
                        }
                      },
                      containerColor: Colors.red,
                      icons: const Icon(
                        Icons.check_circle_sharp,
                        color: Colors.white,
                      ),
                      title: 'Save',
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    EditContainerTasks(
                      containerColor: isEdit ? Colors.grey : Colors.orange,
                      onTap: () {
                        setState(() {
                          isEdit = true;
                        });
                      },
                      icons: SvgPicture.asset('assets/icons/edit.svg'),
                      title: 'Edit',
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    EditContainerTasks(
                      containerColor: Colors.grey,
                      onTap: _deleteTask,
                      icons: const Icon(
                        CupertinoIcons.delete_solid,
                        color: Colors.white,
                      ),
                      title: 'CANCEL',
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                        'assets/icons/vector${widget.task.priority + 1}.svg'),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.time, color: Colors.white),
                        SizedBox(width: 1.5.w),
                        Text(
                          widget.task.date,
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
                SizedBox(height: 2.h),
                !isEdit
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.5.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            widget.task.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 15.5.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          CustomEditTaskTextField(
                            maxLines: 1,
                            label: 'Title',
                            controller: titleController,
                            readOnly: !isEdit,
                          ),
                          SizedBox(height: 1.h),
                          CustomEditTaskTextField(
                            maxLines: 4,
                            label: 'Description',
                            controller: descriptionController,
                            readOnly: !isEdit,
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditContainerTasks extends StatelessWidget {
  const EditContainerTasks({
    super.key,
    required this.title,
    required this.icons,
    required this.containerColor,
    this.onTap,
  });

  final String title;
  final Function()? onTap;
  final Widget icons;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icons,
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomEditTaskTextField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const CustomEditTaskTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.readOnly = true,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
