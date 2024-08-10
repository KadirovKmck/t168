import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/presentation/add_task_screen/widget/custom_add_task_textfild.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/models/note_model.dart';
import 'package:t168/src/models/partners_models.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.partner});
  
  final PartnersModels partner; 

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController noteController = TextEditingController();

  void _saveNote() {
    if (noteController.text.isNotEmpty) {
      final newNote = NoteModel(note: noteController.text);

      Provider.of<PartnerProvider>(context, listen: false)
          .addNoteToPartner(widget.partner, newNote);

      noteController.clear();
      Navigator.pop(context);
    }
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
            GestureDetector(
              onTap: _saveNote,
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
