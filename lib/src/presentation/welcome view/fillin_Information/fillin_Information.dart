import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/presentation/welcome%20view/questionnaire_screen/questionnaire_screen.dart';
import 'package:t168/src/providers/profile_provider/profile_provider.dart';

class FillinInformation extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  FillinInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          _controller.text = profileProvider.userName;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
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
                      onTap: () => profileProvider.pickImage(),
                      child: Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                          color: const Color(0xFF272727),
                          image: profileProvider.image != null
                              ? DecorationImage(
                                  image: FileImage(profileProvider.image!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: profileProvider.image == null
                            ? const Icon(
                                Icons.person,
                                size: 90,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    if (profileProvider.image == null) ...[
                      TextButton.icon(
                        onPressed: () => profileProvider.pickImage(),
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
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.black),
                      ),
                    ],
                    SizedBox(height: 2.5.h),
                    if (profileProvider.image != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => profileProvider.pickImage(),
                            child: Container(
                              width: 45.w,
                              height: 5.h,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
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
                            onTap: () => profileProvider.reset(),
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
                    if (profileProvider.showTextField)
                      TextFormField(
                        controller: _controller,
                        onChanged: (value) {
                          profileProvider.updateUserName(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: profileProvider.userName.isEmpty
                              ? const Color(0xFF777777)
                              : Colors.white,
                          hintText: 'User Name',
                          hintStyle: TextStyle(
                              color: profileProvider.userName.isEmpty
                                  ? Colors.white
                                  : Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                            color: profileProvider.userName.isEmpty
                                ? Colors.white
                                : Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'User Name cannot be empty';
                          } else if (value.length < 3) {
                            return 'User Name must be at least 3 characters';
                          }
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        profileProvider.saveProfile();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuestionnaireScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: profileProvider.userName.isEmpty ||
                                  profileProvider.image == null
                              ? const Color(0x7FC75A55)
                              : const Color(0xFF5B0604),
                        ),
                        child: const Center(
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
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
