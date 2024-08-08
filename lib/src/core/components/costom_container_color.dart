import 'package:flutter/material.dart';

class ContainerColor extends StatelessWidget {
  const ContainerColor({super.key, required this.child});

  @override
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: child,
      ),
    );
  }
}
