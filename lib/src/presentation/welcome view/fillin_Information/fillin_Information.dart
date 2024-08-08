import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t168/src/core/components/costom_container_color.dart';
import 'package:t168/src/presentation/welcome%20view/questionnaire_screen/questionnaire_screen.dart';

class FillinInformation extends StatefulWidget {
  const FillinInformation({super.key});

  @override
  State<FillinInformation> createState() => _FillinInformationState();
}

class _FillinInformationState extends State<FillinInformation> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool isEditing = false;
  final TextEditingController _controller = TextEditingController();
  bool isBuildingProfile = false;
  int buttonPressCount = 0;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      final savedPaths = prefs.getStringList('imagePaths') ?? [];
      if (!savedPaths.contains(pickedFile.path)) {
        final updatedPaths = [...savedPaths, pickedFile.path];
        await prefs.setStringList('imagePaths', updatedPaths);
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  void toggleBuildingProfile() {
    setState(() {
      buttonPressCount += 1;
      if (buttonPressCount == 1) {
        isBuildingProfile = true;
      } else if (buttonPressCount == 2 && _image != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuestionnaireScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ContainerColor(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'FILL IN THE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' INFORMATION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    color: const Color(0xFF272727),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? const Icon(
                          Icons.person,
                          size: 90,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 1.h),
              if (_image == null) ...[
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt, color: Colors.grey),
                  label: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'ADD ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: 'PHOTO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                ),
              ],
              SizedBox(height: 2.5.h),
              if (_image != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 45.w,
                        height: 5.h,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'EDIT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TextSpan(
                                  text: ' PHOTO',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _image = null;
                        });
                      },
                      child: Container(
                        width: 45.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF272727),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'REMOVE',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TextSpan(
                                  text: ' PHOTO',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 2.h),
              if (!isBuildingProfile) ...[
                TextField(
                  controller: _controller,
                  onTap: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                  onEditingComplete: () {
                    setState(() {
                      isEditing = false;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: _controller.text.isEmpty
                        ? const Color(0xFF777777)
                        : Colors.white,
                    hintText: 'User Name',
                    hintStyle: TextStyle(
                        color: _controller.text.isEmpty
                            ? Colors.white
                            : Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(
                      color: _controller.text.isEmpty
                          ? Colors.white
                          : Colors.black),
                ),
              ],
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: toggleBuildingProfile,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                      color: _controller.text.isEmpty || _image == null
                          ? const Color(0x7FC75A55)
                          : const Color(0xFF5B0604)),
                  child: Center(
                    child: Text(
                      isBuildingProfile
                          ? 'BUILDING FIGHTER PROFILES'
                          : 'CONTINUE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
