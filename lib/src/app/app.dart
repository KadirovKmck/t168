import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:t168/src/core/components/navbar.dart';

class T168 extends StatelessWidget {
  const T168({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => const MaterialApp(
        home: NavbarView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
