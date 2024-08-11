import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_container.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/models/task_models.dart';
import 'package:t168/src/presentation/add_task_screen/widget/custom_add_task_textfild.dart';
import 'package:t168/src/presentation/main_screens/widgets/priority_tabbar.dart';
import 'package:t168/src/providers/add_task_provider/add_task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _transactionDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();

  int _selectedPriorityIndex = 1;

  void _saveTask() {
    final task = TaskModels(
      title: _titleController.text,
      description: _descriptionController.text,
      date: _transactionDateController.text,
      priority: _selectedPriorityIndex,
    );

    Provider.of<AddTaskProvider>(context, listen: false).addTask(task);

    Navigator.pop(
      context,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 250,
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _transactionDateController.text =
                        "${newDate.year}-${newDate.month}-${newDate.day}";
                  });
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
        title: Text(
          'ADD TASK',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAddTaskTextField(label: 'Title', controller: _titleController),
          SizedBox(height: 1.h),
          CustomAddTaskTextField(
              label: 'Description', controller: _descriptionController),
          SizedBox(height: 1.h),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomAddTaskTextField(
                controller: _transactionDateController,
                label: 'Date',
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          Text(
            'PRIORITY:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          PriorityTabBar(
            selectedIndex: _selectedPriorityIndex,
            onChanged: (int index) {
              setState(() {
                _selectedPriorityIndex = index;
              });
            },
          ),
          SizedBox(height: 3.h),
          GestureDetector(
            onTap: _saveTask,
            child: const CustomContainer(
              title: 'ADD',
            ),
          ),
        ],
      ),
    );
  }
}
