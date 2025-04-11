import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.validator,  this.readOnly = false,
  });
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      keyboardType: label == "Email"
          ? TextInputType.emailAddress
          : label == 'Student ID'
              ? TextInputType.number
              : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Color(0xff757575),
        ),
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(label),
        labelStyle: const TextStyle(
          color: Color(0xff757575),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xff757575),
          ),
        ),
      ),
    );
  }
}
