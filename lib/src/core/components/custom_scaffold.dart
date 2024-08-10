import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.body, this.appBar});
  final Widget? body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    // Получаем текущую тему
    var theme = Theme.of(context);

    var colors = theme.brightness == Brightness.dark
        ? [Colors.black, const Color(0xFF1A1A1A)] // Темная тема
        : [Colors.white, const Color(0xFFE0E0E0)]; // Светлая тема
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // Используем цвета из текущей темы для градиента
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: colors,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: SafeArea(child: body!),
      ),
    );
  }
}
