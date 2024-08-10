import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/custom_scaffold.dart';
import 'package:t168/src/core/components/navbar.dart';

class LodingScreen extends StatelessWidget {
  const LodingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelektZem()),
      );
    });
    var theme = Theme.of(context);
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'LOADING... \n',
                  style: TextStyle(
                    color: theme.textTheme.titleLarge?.color ?? Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const TextSpan(
                  text: 'CUSTOMIZE THE APPLICATION FOR YOU',
                  style: TextStyle(
                    color: Color(0xFFC9271E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class SelektZem extends StatefulWidget {
  const SelektZem({super.key});

  @override
  State<SelektZem> createState() => _SelektZemState();
}

class _SelektZemState extends State<SelektZem> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'SELECT A DESIGN',
                  style: TextStyle(
                    color: theme.textTheme.titleLarge?.color ?? Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const TextSpan(
                  text: ' ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'THEME',
                  style: TextStyle(
                    color: theme.textTheme.titleLarge?.color ?? Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _changeTheme(ThemeMode.light),
                  child: Container(
                    height: 25.h,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF5A6A7A)),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Light',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: InkWell(
                  onTap: () => _changeTheme(ThemeMode.dark),
                  child: Container(
                    color: Colors.black,
                    height: 25.h,
                    child: const Center(
                      child: Text(
                        'Dark',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: () {
              _changeTheme(ThemeMode.system);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavbarView(),
                ),
              );
            },
            child: Container(
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xFF5B0604),
                border: Border.all(width: 1),
              ),
              child: const Center(
                child: Text(
                  'OR A SYSTEM DESIGN THEME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeTheme(ThemeMode mode) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    provider.setTheme(mode);
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
