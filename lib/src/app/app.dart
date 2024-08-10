import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/app/theme/app_theme.dart';
import 'package:t168/src/presentation/welcome%20view/loding_screen/loding_screen.dart';
import 'package:t168/src/presentation/welcome%20view/splash_screen.dart';

class T168 extends StatelessWidget {
  const T168({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ResponsiveSizer(builder: (p0, p1, p2) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode:
            themeProvider.themeMode, // Bind the theme mode to the provider
        theme: ThemeData.light(), // Define your light theme here
        darkTheme: ThemeData.dark(), // Define your dark theme here
        home: const SplashScreen(),
      );
    });
  }
}
