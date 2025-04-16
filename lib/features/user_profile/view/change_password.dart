import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/core/utils/validators.dart';
import 'package:fcai_app/core/widgets/auth_label.dart';
import 'package:fcai_app/core/widgets/custom_button.dart';
import 'package:fcai_app/core/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/ChangePassword.png',
                  ),
                  SizedBox(height: 20),
                  AuthLabel(
                    label: "Change Password",
                    fontSize: 24,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    label: "Old password",
                    controller: oldPasswordController,
                    validator: (value) => Validators.validateOldPassword(
                      value,
                      oldPassword: widget.userModel.password,
                    ),
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: Validators.validatePassword,
                    label: "New password",
                    controller: passwordController,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
                    label: "Confirm new password",
                    controller: confirmPasswordController,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    label: "Save password",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        UserModel updatedUser = UserModel(
                          name: widget.userModel.name,
                          id: widget.userModel.id,
                          email: widget.userModel.email,
                          password: passwordController.text,
                          gender: widget.userModel.gender,
                          level: widget.userModel.level,
                          imageUrl: widget.userModel.imageUrl,
                        );

                        Box<UserModel> box;

                        if (!hiveService.isBoxOpen(boxName: "user")) {
                          box = await hiveService.openBox(boxName: "user");
                        } else {
                          box = Hive.box<UserModel>("user");
                        }

                        await hiveService.putData(
                            box: box,
                            key: updatedUser.email,
                            value: updatedUser);

                        if (!context.mounted) return;

                        Helpers.showSuccessSnackBar(
                            context, "Password changed scuccessfully!");
                        Navigator.pop(context);
                      }
                    },
                    color: 0xff247CFF,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
