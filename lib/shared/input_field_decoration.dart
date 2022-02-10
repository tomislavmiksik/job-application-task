import 'package:flutter/material.dart';

class InputFieldDecoration {
  static InputDecoration buildInputDecoration(String label, BuildContext context) {
    return InputDecoration(
      errorStyle: const TextStyle(
        color: Color(0xFFEB5757),
        fontWeight: FontWeight.bold,
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
