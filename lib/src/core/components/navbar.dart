import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> views = [
    // const HomePage(),
    // const HistoryPage(),
    // const AddPage(),
    // const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[_currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 11.h,
        decoration: const BoxDecoration(
          color: Color(0xffFFC86A),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffFFC86A),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          onTap: (value) => setState(() {
            _currentIndex = value;
          }),
          selectedLabelStyle: const TextStyle(
            color: Colors.white,
          ),
          unselectedLabelStyle: const TextStyle(
            color: Colors.white60,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/main.svg',
                height: 23,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/main_ac.svg',
                height: 23,
              ),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/history.svg',
                height: 27,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/history_ac.svg',
                height: 27,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/add.svg',
                height: 23,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/add.svg',
                height: 23,
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/settigns.svg',
                height: 23,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/settigns_ac.svg',
                height: 23,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
