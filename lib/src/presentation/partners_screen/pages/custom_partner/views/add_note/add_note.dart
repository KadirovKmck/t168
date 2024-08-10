import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/app/add_task_screen/widget/custom_add_task_textfild.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController noteController = TextEditingController();
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
          'Note writing',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAddTaskTextField(
              keyboardType: TextInputType.name,
              controller: noteController,
              hintext: 'Write your note',
              label: 'Note',
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              width: 90.w,
              height: 7.5.h,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Color(0xFFC9271E),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Text(
                  'SAVE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
