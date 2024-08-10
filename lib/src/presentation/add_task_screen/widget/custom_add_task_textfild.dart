import 'package:flutter/material.dart';

class CustomAddTaskTextField extends StatelessWidget {
  final String label;
  final String? hintext;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const CustomAddTaskTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintext,
        labelText: label,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
