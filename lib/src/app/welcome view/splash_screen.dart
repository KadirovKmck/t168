import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t168/src/core/components/navbar.dart';
import 'package:t168/src/app/welcome%20view/onbording_sreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 6),
      () {
        _checkStatus();
      },
    );
  }

  Future<void> _checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSaved = prefs.getBool('isSaved') ?? false;
    if (isSaved) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavbarView(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/loading.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 2.h),
                const Text('Loading...', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
