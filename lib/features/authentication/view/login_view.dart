import 'package:fcai_app/features/authentication/view/widgets/custom_button.dart';
import 'package:fcai_app/features/authentication/view/widgets/custom_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/Group 1.png',
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                const CustomTextField(
                  label: "Email",
                  icon: Icons.email,
                ),
                SizedBox(height: 20),
                const PasswordTextField(),
                SizedBox(height: 40),
                CustomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
