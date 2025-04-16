import 'package:flutter/material.dart';

class AuthLabel extends StatelessWidget {
  const AuthLabel({super.key, required this.label, required this.fontSize});
  final String label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
