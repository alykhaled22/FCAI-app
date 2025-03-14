import 'dart:io';
import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/features/authentication/view/widgets/gender_radio.dart';
import 'package:fcai_app/features/authentication/view/widgets/level_dropdown.dart';
import 'package:fcai_app/features/authentication/view/widgets/password_text_field.dart';
import 'package:fcai_app/features/user_profile/view/widgets/add_image_avatar.dart';
import 'package:fcai_app/features/user_profile/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class UserEditInfo extends StatefulWidget {
  const UserEditInfo({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UserEditInfo> createState() => _UserEditInfoState();
}

class _UserEditInfoState extends State<UserEditInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? selectedGender;
  int? selectedLevel;
  HiveService hiveService = HiveService();

  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userModel.name;
    idController.text = widget.userModel.id;
    emailController.text = widget.userModel.email;
    selectedLevel = int.tryParse(widget.userModel.level ?? "");
    selectedGender = widget.userModel.gender;
    image = widget.userModel.imageUrl != null && widget.userModel.imageUrl != ""
        ? File(widget.userModel.imageUrl!)
        : image;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAppBar(
                      iconL: Icons.arrow_back_ios,
                      iconR: Icons.done,
                      onPressedL: () {
                        Navigator.pop(context);
                      },
                      onPressedR: () async {
                        if (formKey.currentState!.validate()) {
                          UserModel updatedUser = UserModel(
                            name: nameController.text.isNotEmpty
                                ? nameController.text
                                : widget.userModel.name,
                            id: widget.userModel.id,
                            email: widget.userModel.email,
                            password: passwordController.text.isNotEmpty
                                ? passwordController.text
                                : widget.userModel.password,
                            gender: selectedGender ?? widget.userModel.gender,
                            level: selectedLevel?.toString() ??
                                widget.userModel.level,
                            imageUrl: image != null ? image!.path : "",
                          );

                          Box<UserModel> box;

                          if (!hiveService.isBoxOpen(boxName: "user")) {
                            box = await hiveService.openBox(boxName: "user");
                          } else {
                            box = Hive.box<UserModel>("user");
                          }
                          await hiveService.openBox(
                              boxName: 'userBox'); // Ensure box is open
                          await hiveService.putData(
                              box: box,
                              key: updatedUser.email,
                              value: updatedUser);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Edited scuccessfully!")));
                          Navigator.pop(
                              context, updatedUser); // Return updated data
                        }
                      },
                    ),
                    AddImageAvatar(
                      image: image != null ? image!.path : "",
                      userModel: widget.userModel,
                      onTap: getImage,
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      label: "Name",
                      icon: Icons.person,
                      controller: nameController,
                      readOnly: false,
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    GenderRadio(
                        gender: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        }),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Student ID",
                      icon: Icons.confirmation_number,
                      controller: idController,
                      readOnly: true,
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: LevelDropDown(
                            initialLevel: selectedLevel,
                            onSelected: (level) {
                              setState(() {
                                selectedLevel = level;
                              });
                            })),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Email",
                      icon: Icons.email,
                      controller: emailController,
                      readOnly: true,
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    PasswordTextField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          if (!RegExp(r'^(?=.*\d).{8,}$').hasMatch(value)) {
                            return "Password must contain at least one number";
                          }
                        }
                        return null;
                      },
                      label: "Change password",
                      controller: passwordController,
                    ),
                    SizedBox(height: 20),
                    PasswordTextField(
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.isEmpty &&
                                passwordController.text.isNotEmpty) {
                              return "This field is required";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                          }
                          return null;
                        },
                        label: "Confirm password",
                        controller: confirmPasswordController),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
