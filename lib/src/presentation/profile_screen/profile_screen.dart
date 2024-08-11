import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/costom_container_color.dart';
import 'package:t168/src/presentation/profile_screen/pages/edit_profil.dart';
import 'package:t168/src/presentation/profile_screen/pages/feed_back.dart';
import 'package:t168/src/presentation/welcome%20view/loding_screen/loding_screen.dart';
import 'package:t168/src/presentation/welcome%20view/splash_screen.dart';
import 'package:t168/src/providers/add_task_provider/add_task_provider.dart';
import 'package:t168/src/providers/partner_provider/partner_provider.dart';
import 'package:t168/src/providers/profile_provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void showDeleteAccountDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete the account?'),
          content: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
                'If you delete your account, you will lose all data and information from the app'),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                // Удалить все данные
                final profileProvider =
                    Provider.of<ProfileProvider>(context, listen: false);
                final partnerProvider =
                    Provider.of<PartnerProvider>(context, listen: false);
                final taskProvider =
                    Provider.of<AddTaskProvider>(context, listen: false);

                await profileProvider.deleteAllData();
                partnerProvider.deleteAllData();
                taskProvider.deleteAllData();

                // Возврат на экран входа или другой основной экран
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
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
                      profileProvider.updateProfile(
                        image: result['image'],
                        name: result['name'],
                      );
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
                            image: profileProvider.image != null
                                ? DecorationImage(
                                    image: FileImage(profileProvider.image!),
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
                        SizedBox(
                          width: 45.w,
                          child: Text(
                            profileProvider.userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.clip,
                            ),
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
                  value: theme.isDarkTheme,
                  onChanged: (value) {
                    theme.toggleTheme(
                        value); // This should update the provider's theme mode
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                  activeColor: Colors.red,
                ),
              ),
              SizedBox(height: 1.h),
              _buildOptionTile(
                icon: Icons.notifications,
                title: 'NOTIFICATIONS',
                trailing: Switch(
                  value: profileProvider.isNotificationsEnabled,
                  onChanged: (value) {
                    profileProvider.toggleNotifications(value);
                  },
                  activeColor: Colors.red,
                ),
              ),
              SizedBox(height: 1.h),
              GestureDetector(
                onTap: profileProvider.rateApp,
                child: _buildOptionTile(icon: Icons.star, title: 'RATE US'),
              ),
              SizedBox(height: 1.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedBack(),
                      ));
                },
                child: _buildOptionTile(
                  icon: Icons.feedback,
                  title: 'FEEDBACK',
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  showDeleteAccountDialog(context);
                },
                child: Text(
                  'DELETE ACCOUNT',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3499999940395355),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
            ],
          ),
        );
      },
    );
  }

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
}
