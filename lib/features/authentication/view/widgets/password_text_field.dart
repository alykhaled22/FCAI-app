import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:(value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: obscureText? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          color: Color(0xff757575),
        ),
        prefixIcon: Icon(
          Icons.password,
          color: Color(0xff757575),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text("Password"),
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
