import 'dart:io';
import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/core/widgets/gender_radio.dart';
import 'package:fcai_app/core/widgets/level_dropdown.dart';
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

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
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
                            id: idController.text.isNotEmpty
                                ? idController.text
                                : widget.userModel.id,
                            email: emailController.text.isNotEmpty
                                ? emailController.text
                                : widget.userModel.email,
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

                          if (updatedUser.email != widget.userModel.email) {
                            await hiveService.deleteData(
                                box: box, key: widget.userModel.email);
                          }

                          await hiveService.putData(
                              box: box,
                              key: updatedUser.email,
                              value: updatedUser);

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Edited scuccessfully!")));
                          Navigator.pop(context, updatedUser);
                        }
                      },
                    ),
                    AddImageAvatar(
                      image: image != null ? image!.path : "",
                      userModel: widget.userModel,
                      onTap: showImagePicker,
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      label: "Name",
                      icon: Icons.person,
                      controller: nameController,
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
                      validator: (value) {
                        if (value!.isEmpty &&
                            emailController.text.isNotEmpty &&
                            emailController.text != widget.userModel.email) {
                          return "This field is required";
                        }
                        if (value.length != 8 && value.isNotEmpty) {
                          return "Student ID must be 8 digits";
                        }
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
                      validator: (value) {
                        if (value!.isEmpty &&
                            idController.text.isNotEmpty &&
                            idController.text != widget.userModel.id) {
                          return "This field is required";
                        }
                        if (value.isNotEmpty && idController.text.isNotEmpty) {
                          final emailRegex =
                              RegExp(r'^(\d+)@stud\.fci-cu\.edu\.eg$');
                          final match = emailRegex.firstMatch(value);

                          if (match == null) {
                            return "Enter a valid FCAI email. \nex:studentID@stud.fci-cu.edu.eg";
                          }

                          if (match.group(1) != idController.text) {
                            return "Email must match student ID";
                          }
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
