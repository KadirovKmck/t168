import 'package:flutter/material.dart';

class PartnerCustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;
  final TextInputType? keyboardType;

  const PartnerCustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
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
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
