import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t168/src/presentation/main_screens/main_screen.dart';
import 'package:t168/src/presentation/partners_screen/partners_screen.dart';
import 'package:t168/src/presentation/plan_screen/plan_screen.dart';
import 'package:t168/src/presentation/profile_screen/profile_screen.dart';

class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  int _currentIndex = 0;
  final List<Widget> views = [
    const MainScreen(),
    const PartnersScreen(),
    const PlanScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF282828),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: _currentIndex == 0 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/partners.svg',
                color: _currentIndex == 1 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/planns.svg',
                color: _currentIndex == 2 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/planns.svg',
                color: _currentIndex == 3 ? Colors.white : Colors.grey,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
