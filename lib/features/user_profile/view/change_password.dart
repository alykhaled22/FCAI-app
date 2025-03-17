import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Change password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    label: "Old password",
                    controller: oldPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      if (value != widget.userModel.password) {
                        return "Wrong password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      if (!RegExp(r'^(?=.*\d).{8,}$').hasMatch(value)) {
                        return "Password must contain at least one number";
                      }

                      return null;
                    },
                    label: "New password",
                    controller: passwordController,
                  ),
                  SizedBox(height: 20),
                  PasswordTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
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
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Password changed scuccessfully!")));
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
