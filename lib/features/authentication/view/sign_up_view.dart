import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/utils/validators.dart';
import 'package:fcai_app/core/widgets/auth_label.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/core/widgets/gender_radio.dart';
import 'package:fcai_app/core/widgets/level_dropdown.dart';
import 'package:fcai_app/core/widgets/password_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/auth_button.dart';
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
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    idController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<UserProvider>(context).isLoading;

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
                AuthButton(
                  isLoading: isLoading,
                  label: "Sign up",
                  onPressed: () async => await _handleSignUp(),
                ),
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
    final password = passwordController.text.trim();

    UserModel userModel = UserModel(
      email: email,
      name: nameController.text.trim(),
      id: idController.text.trim(),
      level: selectedLevel,
      password: password,
      gender: selectedGender,
      imageUrl: "",
    );

    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await authProvider.registerUser(userModel, context);

    if (!mounted) return;
    if (success) Navigator.pop(context);
  }
}
