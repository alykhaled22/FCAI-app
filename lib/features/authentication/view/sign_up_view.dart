import 'package:fcai_app/core/widgets/custom_button.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/gender_radio.dart';
import 'package:fcai_app/features/authentication/view/widgets/level_dropdown.dart';
import 'package:fcai_app/features/authentication/view/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              const CustomTextField(label: "Full Name", icon: Icons.person),
              SizedBox(height: 20),
              GenderRadio(),
              SizedBox(height: 20),
              const CustomTextField(
                  label: "Student ID", icon: Icons.confirmation_number),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: LevelDropDown(),
              ),
              SizedBox(height: 20),
              const CustomTextField(label: "FCAI Email", icon: Icons.email),
              SizedBox(height: 20),
              const PasswordTextField(label: "Password"),
              SizedBox(height: 20),
              const PasswordTextField(label: "Confirm password"),
              SizedBox(height: 40),
              CustomButton(label: "Sign up", onPressed: () {}, color: 0xff247CFF),
            ],
          ),
        ),
      ),
    ));
  }
}
