import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.body, this.appBar});
  final Widget? body;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Colors.black, Color(0xFF1A1A1A)],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: SafeArea(child: body!),
      ),
    );
  }
}
