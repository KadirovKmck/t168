import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/models/partners_models.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/image_picker_widget.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/partner_custom_textfield.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';
import 'package:t168/src/presentation/partners_screen/pages/widgets/add_priority_tabbar.dart';

class PartnerEdit extends StatefulWidget {
  const PartnerEdit({super.key, required this.partner});
  final PartnersModels partner;

  @override
  State<PartnerEdit> createState() => _PartnerEditState();
}

class _PartnerEditState extends State<PartnerEdit> {
  late TextEditingController companyNameController;
  late TextEditingController descriptionController;
  late TextEditingController _startDateController;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  int _selectedPriorityIndex = 0;

  @override
  void initState() {
    super.initState();
    companyNameController =
        TextEditingController(text: widget.partner.companyName);
    descriptionController =
        TextEditingController(text: widget.partner.description);
    _startDateController =
        TextEditingController(text: widget.partner.startDate);
    _selectedPriorityIndex = widget.partner.status;
    if (widget.partner.photo.isNotEmpty) {
      imageFile = File(widget.partner.photo);
    }
  }

  void _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
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
                        "${newDate.year}/${newDate.month}/${newDate.day}";
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

  void _saveInformation() {
    if (_formKey.currentState!.validate()) {
      final updatedPartner = PartnersModels(
        companyName: companyNameController.text,
        status: _selectedPriorityIndex,
        description: descriptionController.text,
        startDate: _startDateController.text,
        photo: imageFile != null ? imageFile!.path : widget.partner.photo,
      );
      Provider.of<PartnerProvider>(context, listen: false)
          .updatePartner(widget.partner, updatedPartner);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        title: Text(
          'Edit Partner',
          style: TextStyle(
            color: const Color(0xFFFBFBFB),
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ImagePickerWidget(
                  image: imageFile,
                  onPickImage: _pickImage,
                ),
                SizedBox(height: 1.h),
                if (imageFile == null) AddPhotoButton(onPickImage: _pickImage),
                SizedBox(height: 2.5.h),
                if (imageFile != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: EditRemoveButtons(
                          onEdit: _pickImage,
                          onRemove: () {
                            setState(() {
                              imageFile = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 1.5.h),
                PartnerCustomTextField(
                  controller: companyNameController,
                  hintText: 'Company name',
                ),
                SizedBox(height: 1.h),
                PartnerCustomTextField(
                  controller: descriptionController,
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
                ElevatedButton(
                  onPressed: _saveInformation,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
