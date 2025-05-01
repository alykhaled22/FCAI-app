import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/core/utils/validators.dart';
import 'package:fcai_app/core/widgets/auth_label.dart';
import 'package:fcai_app/features/authentication/view/widgets/auth_button.dart';
import 'package:fcai_app/core/widgets/password_text_field.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late UserModel currentUser;

  @override
  void initState() {
    currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
                  Image.asset('assets/images/change_password.png'),
                  SizedBox(height: 20),
                  AuthLabel(label: "Change Password", fontSize: 24),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: Validators.validateRequiredField,
                    label: "Old password",
                    controller: oldPasswordController,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: Validators.validatePassword,
                    label: "New password",
                    controller: newPasswordController,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      newPasswordController.text,
                    ),
                    label: "Confirm new password",
                    controller: confirmPasswordController,
                  ),
                  SizedBox(height: 40),
                  AuthButton(
                    isLoading: isLoading,
                    label: "Save password",
                    onPressed: () async => await _handleChangePass(),
                  ),
                  SizedBox(height: 20),
                  AuthButton(
                    label: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    buttonColor: Colors.white,
                    buttonTextColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleChangePass() async {
    if (!formKey.currentState!.validate()) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final success = await userProvider.updateUserPass(
        newPasswordController.text, oldPasswordController.text, context);

    if (!success || !mounted) {
      return;
    }

    Helpers.showSuccessSnackBar(context, "Password changed scuccessfully!");
    Navigator.pop(context);
  }
}
