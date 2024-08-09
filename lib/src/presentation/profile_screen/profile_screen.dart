import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/costom_container_color.dart';
import 'package:t168/src/presentation/profile_screen/pages/edit_profil.dart';
import 'package:t168/src/presentation/profile_screen/pages/feed_back.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkTheme = true;
  bool isNotificationsEnabled = true;
  File? _image;
  String _userName = "ALEX STONE";

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    Widget? trailing,
  }) {
    return Container(
      width: 95.w,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Color(0xFF242628)),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return ContainerColor(
      child: Column(
        children: [
          Container(
            height: 25.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 67, 67, 67),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfil(),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _image = result['image'];
                    _userName = result['name'];
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 30),
                child: Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 15.h,
                      decoration: ShapeDecoration(
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.fill,
                              )
                            : const DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/120x120"),
                                fit: BoxFit.fill,
                              ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      _userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    SvgPicture.asset(
                      'assets/icons/edit.svg',
                      height: 2.3.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          _buildOptionTile(
            icon: Icons.dark_mode,
            title: 'DARK THEME',
            trailing: Switch(
              value: isDarkTheme,
              onChanged: (value) {
                setState(() {
                  isDarkTheme = value;
                });
              },
              activeColor: Colors.red,
            ),
          ),
          SizedBox(height: 1.h),
          _buildOptionTile(
            icon: Icons.notifications,
            title: 'NOTIFICATIONS',
            trailing: Switch(
              value: isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
              activeColor: Colors.red,
            ),
          ),
          SizedBox(height: 1.h),
          _buildOptionTile(icon: Icons.star, title: 'RATE US'),
          SizedBox(height: 1.h),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedBack(),
                    ));
              },
              child: _buildOptionTile(icon: Icons.feedback, title: 'FEEDBACK')),
          const Spacer(),
          Text(
            'DELETE ACCOUNT',
            style: TextStyle(
              color: Colors.white.withOpacity(0.3499999940395355),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
        ],

      ),
    );
  }
}
