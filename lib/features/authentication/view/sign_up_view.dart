import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/widgets/custom_button.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/core/widgets/gender_radio.dart';
import 'package:fcai_app/core/widgets/level_dropdown.dart';
import 'package:fcai_app/core/widgets/password_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/swap_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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

  final HiveService hiveService = HiveService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
          child: Form(
            key: formKey,
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
                CustomTextField(
                  readOnly: false,
                  label: "Full Name",
                  icon: Icons.person,
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
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
                    readOnly: false,
                    label: "Student ID",
                    icon: Icons.confirmation_number,
                    controller: idController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      if (value.length != 8) {
                        return "Student ID must be 8 digits";
                      }
                      return null;
                    }),
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
                  readOnly: false,
                  label: "FCAI Email",
                  icon: Icons.email,
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) return "This field is required";

                    final emailRegex = RegExp(r'^(\d+)@stud\.fci-cu\.edu\.eg$');
                    final match = emailRegex.firstMatch(value);

                    if (match == null) {
                      return "Enter a valid FCAI email. \nex:studentID@stud.fci-cu.edu.eg";
                    }

                    if (match.group(1) != idController.text) {
                      return "Email must match student ID";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 17),
                PasswordTextField(
                  label: "Password",
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return "This field is required";
                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    if (!RegExp(r'^(?=.*\d).{8,}$').hasMatch(value)) {
                      return "Password must contain at least one number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 17),
                PasswordTextField(
                    label: "Confirm password",
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) return "This field is required";
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    }),
                SizedBox(height: 40),
                CustomButton(
                    label: "Sign up",
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      Box<UserModel> box;

                      if (!hiveService.isBoxOpen(boxName: "user")) {
                        box = await hiveService.openBox(boxName: "user");
                      } else {
                        box = Hive.box<UserModel>("user");
                      }

                      if (!context.mounted) return;

                      if (box.containsKey(emailController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "User with the same Email already exists!")));
                        return;
                      }

                      UserModel user = UserModel(
                        id: idController.text,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        gender: selectedGender,
                        level: selectedLevel,
                      );

                      await hiveService.putData(
                          box: box, key: emailController.text, value: user);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Signed up scuccessfully!")));
                      Navigator.pop(context);
                    },
                    color: 0xff247CFF),
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
}
