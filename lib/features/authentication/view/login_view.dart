import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/widgets/custom_button.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/features/authentication/view/sign_up_view.dart';
import 'package:fcai_app/features/authentication/view/widgets/password_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/swap_auth.dart';
import 'package:fcai_app/features/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HiveService hiveService = HiveService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/Group 1.png',
                  ),
                  SizedBox(height: 60),
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
                  CustomTextField(
                    readOnly: false,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    label: "Email",
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    label: "Password",
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                      label: "Login",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Box<UserModel> box;

                          if (!hiveService.isBoxOpen(boxName: "user")) {
                            box = await hiveService.openBox(boxName: "user");
                          } else {
                            box = Hive.box<UserModel>("user");
                          }

                          UserModel? user = hiveService.getData(
                              box: box, key: emailController.text);

                          if (user == null ||
                              passwordController.text != user.password) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Invalid email or password")),
                            );
                            return;
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login successful!")),
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile(
                                        userModel: user,
                                      )));
                        }
                      },
                      color: 0xff247CFF),
                  SizedBox(height: 10),
                  SwapAuth(
                      label: "Don't have an account?",
                      action: "Sign up Now!",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpView()));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
