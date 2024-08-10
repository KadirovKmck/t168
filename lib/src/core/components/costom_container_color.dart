import 'package:flutter/material.dart';

class ContainerColor extends StatelessWidget {
  const ContainerColor({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Получаем текущую тему
    var theme = Theme.of(context);
    var colors = theme.brightness == Brightness.dark
        ? [Colors.black, const Color(0xFF1A1A1A)] // Темная тема
        : [Colors.white, const Color(0xFFE0E0E0)]; // Светлая тема

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: colors,
          ),
        ),
        child: child,
      ),
    );
  }
}
