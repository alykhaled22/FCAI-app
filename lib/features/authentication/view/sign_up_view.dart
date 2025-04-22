import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/core/utils/validators.dart';
import 'package:fcai_app/core/widgets/auth_label.dart';
import 'package:fcai_app/core/widgets/custom_button.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/core/widgets/gender_radio.dart';
import 'package:fcai_app/core/widgets/level_dropdown.dart';
import 'package:fcai_app/core/widgets/password_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/swap_auth.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedGender;
  String? selectedLevel;

  final HiveService hiveService = HiveService<UserModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AuthLabel(label: "Sign Up", fontSize: 28),
                SizedBox(height: 30),
                CustomTextField(
                  label: "Full Name",
                  icon: Icons.person,
                  controller: nameController,
                  validator: Validators.validateRequiredField,
                ),
                SizedBox(height: 17),
                GenderRadio(
                    gender: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    }),
                SizedBox(height: 17),
                CustomTextField(
                  label: "Student ID",
                  icon: Icons.confirmation_number,
                  controller: idController,
                  validator: Validators.validateStudentId,
                ),
                SizedBox(height: 17),
                Align(
                  alignment: Alignment.centerLeft,
                  child: LevelDropDown(
                      initialLevel: int.tryParse(selectedLevel ?? ""),
                      onSelected: (level) {
                        setState(() {
                          selectedLevel = level.toString();
                        });
                      }),
                ),
                SizedBox(height: 17),
                CustomTextField(
                  label: "FCAI Email",
                  icon: Icons.email,
                  controller: emailController,
                  validator: (value) =>
                      Validators.validateFcaiEmail(value, idController.text),
                ),
                SizedBox(height: 17),
                PasswordTextField(
                  label: "Password",
                  controller: passwordController,
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: 17),
                PasswordTextField(
                  label: "Confirm password",
                  controller: confirmPasswordController,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                ),
                SizedBox(height: 40),
                CustomButton(
                    label: "Sign up",
                    onPressed: () async => await _handleSignUp(),
                    color: AppColors.primaryColor),
                SizedBox(
                  height: 10,
                ),
                SwapAuth(
                  label: "Already have an account?",
                  action: "Login",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _handleSignUp() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();

    if (!mounted) return;

    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await authProvider.isUserExists(email);

    if (success) {
      if (!mounted) return;
      Helpers.showErrorSnackBar(
          context, "User with the same Email already exists!");
      return;
    } else {
      UserModel user = UserModel(
        id: idController.text,
        name: nameController.text,
        email: email,
        password: passwordController.text,
        gender: selectedGender,
        level: selectedLevel,
      );
      await authProvider.registerUser(user, email);
    }

    if (!mounted) return;

    Helpers.showSuccessSnackBar(context, "Signed up scuccessfully!");
    Navigator.pop(context);
  }
}
