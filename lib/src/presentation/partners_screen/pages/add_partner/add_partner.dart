import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'dart:io';

import 'package:t168/src/models/partners_models.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/image_picker_widget.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/partner_custom_textfield.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/add_priority_tabbar.dart';

class AddPartner extends StatefulWidget {
  const AddPartner({super.key});

  @override
  State<AddPartner> createState() => _AddPartnerState();
}

class _AddPartnerState extends State<AddPartner> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  int _selectedPriorityIndex = 1;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
                    _startDateController.text =
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

  void _addPartner(BuildContext context) {
    if (_formKey.currentState!.validate() && _image != null) {
      final newPartner = PartnersModels(
        companyName: _companyNameController.text,
        description: _descriptionController.text,
        startDate: _startDateController.text,
        photo: _image!.path,
        status: _selectedPriorityIndex,
      );

      Provider.of<PartnerProvider>(context, listen: false)
          .addPartner(newPartner);
      Navigator.pop(context);
    } else {
      // Show an error message or validation feedback if necessary
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and add a photo'),
        ),
      );
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
          'Add Partner',
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ImagePickerWidget(
                  image: _image,
                  onPickImage: _pickImage,
                ),
                SizedBox(height: 1.h),
                if (_image == null) AddPhotoButton(onPickImage: _pickImage),
                SizedBox(height: 2.5.h),
                if (_image != null)
                  EditRemoveButtons(
                    onEdit: _pickImage,
                    onRemove: () {
                      setState(() {
                        _image = null;
                      });
                    },
                  ),
                SizedBox(height: 1.5.h),
                PartnerCustomTextField(
                  controller: _companyNameController,
                  hintText: 'Company name',
                ),
                SizedBox(height: 1.h),
                PartnerCustomTextField(
                  controller: _descriptionController,
                  hintText: 'Description',
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: PartnerCustomTextField(
                      controller: _startDateController,
                      hintText: 'Start date',
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'STATUS:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                AddPriorityTabBar(
                  selectedIndex: _selectedPriorityIndex,
                  onChanged: (int index) {
                    setState(() {
                      _selectedPriorityIndex = index;
                    });
                  },
                ),
                SizedBox(height: 2.h),
                AddButton(onAdd: () => _addPartner(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onAdd;

  const AddButton({
    super.key,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Opacity(
        opacity: 0.60,
        child: Container(
          height: 6.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF5B0604),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Center(
            child: Text(
              'ADD',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
