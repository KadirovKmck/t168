
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FrostedGlassButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const FrostedGlassButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  _FrostedGlassButtonState createState() => _FrostedGlassButtonState();
}

class _FrostedGlassButtonState extends State<FrostedGlassButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isTapped ? 6.h : 7.5.h,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF5B0604),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
