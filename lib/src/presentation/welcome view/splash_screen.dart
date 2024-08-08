import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t168/src/core/components/navbar.dart';
import 'package:t168/src/presentation/welcome%20view/onbording_sreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    Future.delayed(
      const Duration(seconds: 5),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/loading.png'),
              fit: BoxFit.cover,
            )),
            child: const Text('smxbkj'),
          ),
        ),
      ),
    );
  }
}
