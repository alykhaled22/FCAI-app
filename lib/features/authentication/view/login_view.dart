import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/core/utils/validators.dart';
import 'package:fcai_app/core/widgets/auth_label.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/core/view/app_navigation.dart';
import 'package:fcai_app/features/authentication/view/sign_up_view.dart';
import 'package:fcai_app/core/widgets/password_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/auth_button.dart';
import 'package:fcai_app/features/authentication/view/widgets/swap_auth.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HiveService hiveService = HiveService<UserModel>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/login.png'),
                  SizedBox(height: 40),
                  AuthLabel(label: "Login", fontSize: 28),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    validator: Validators.validateRequiredField,
                    label: "Email",
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    controller: passwordController,
                    validator: Validators.validateRequiredField,
                    label: "Password",
                  ),
                  SizedBox(height: 40),
                  AuthButton(
                    isLoading: isLoading,
                    label: "Login",
                    onPressed: () async => await _handleLogin(),
                  ),
                  SizedBox(height: 10),
                  SwapAuth(
                      label: "Don't have an account?",
                      action: "Sign up Now!",
                      onPressed: () {
                        Helpers.navigateWithSlide(context, SignUpView());
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await authProvider.loginUser(email, password, context);

    if (success) {
      if (!mounted) return;
      authProvider.loadCurrentUser(context);
      Helpers.navigateWithFadeAndScale(context, AppNavigation());
    }
  }
}
