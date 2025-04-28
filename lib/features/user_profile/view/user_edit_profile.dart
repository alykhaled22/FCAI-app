import 'dart:io';
import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/core/utils/validators.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:fcai_app/core/widgets/gender_radio.dart';
import 'package:fcai_app/core/widgets/level_dropdown.dart';
import 'package:fcai_app/features/authentication/view/widgets/auth_button.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:fcai_app/features/user_profile/view/widgets/add_image_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedGender;
  int? selectedLevel;

  File? image;
  final picker = ImagePicker();

  late UserModel currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).currentUser;
    _initialize();
  }

  void _initialize() {
    nameController.text = currentUser.name;
    idController.text = currentUser.id;
    emailController.text = currentUser.email;
    selectedLevel = int.tryParse(currentUser.level ?? "");
    selectedGender = currentUser.gender;
    image = currentUser.imageUrl != null && currentUser.imageUrl != ""
        ? File(currentUser.imageUrl!)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didpop, result) async {
        if (!isDataChanged()) {
          Navigator.of(context).pop();
          return;
        }
        final confirm = await didPop();
        if (confirm) {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AddImageAvatar(
                      image: image?.path ?? "",
                      userModel: currentUser,
                      onTap: showImagePicker,
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      label: "Name",
                      icon: Icons.person,
                      controller: nameController,
                      validator: (value) => null,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Student ID",
                      icon: Icons.confirmation_number,
                      controller: idController,
                      validator: (value) => Validators.validateUpdatedStudentId(
                        value,
                        currentEmail: emailController.text,
                        originalEmail: currentUser.email,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: "Email",
                      icon: Icons.email,
                      controller: emailController,
                      validator: (value) => Validators.validateUpdatedFcaiEmail(
                        value,
                        currentID: idController.text,
                        originalID: currentUser.id,
                      ),
                    ),
                    SizedBox(height: 20),
                    GenderRadio(
                      gender: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
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
                        },
                      ),
                    ),
                    SizedBox(height: 35),
                    AuthButton(
                      label: "Save Changes",
                      onPressed: () async => await _handleEditProfile(),
                    ),
                    SizedBox(height: 20),
                    AuthButton(
                      label: "Cancel",
                      onPressed: () async {
                        if (!isDataChanged()) {
                          Navigator.of(context).pop();
                          return;
                        }
                        final confirm = await didPop();
                        if (confirm) {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        }
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
      ),
    );
  }

  Future<void> _handleEditProfile() async {
    if (!formKey.currentState!.validate()) return;
    final email = emailController.text.trim();

    UserModel updatedUser = UserModel(
      name: nameController.text.isNotEmpty
          ? nameController.text
          : currentUser.name,
      id: idController.text.isNotEmpty ? idController.text : currentUser.id,
      email: email.isNotEmpty ? email : currentUser.email,
      password: currentUser.password,
      gender: selectedGender ?? currentUser.gender,
      level: selectedLevel?.toString() ?? currentUser.level,
      imageUrl: image != null ? image!.path : "",
    );

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (emailController.text != currentUser.email) {
      final success = await userProvider.isUserExists(email);
      if (success) {
        if (!mounted) return;
        Helpers.showErrorSnackBar(
            context, "User with the same Email already exists!");
        return;
      }
    }

    await userProvider.updateUser(
      updatedUser,
      emailController.text,
      currentUser.email,
    );

    if (!mounted) return;

    Helpers.showSuccessSnackBar(context, "Edited successfully!");
    Navigator.pop(context);
  }

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
      backgroundColor: Colors.white,
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

  Future<bool> didPop() async {
    return await Helpers.alertDialog(
      context,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      title: "Discard Changes?",
      message: "Are you sure you want to leave without saving?",
      actionText: "Leave",
      buttonColor: Colors.red,
    );
  }

  bool isDataChanged() {
    return nameController.text != currentUser.name ||
        idController.text != currentUser.id ||
        emailController.text != currentUser.email ||
        selectedGender != currentUser.gender ||
        selectedLevel.toString() != currentUser.level ||
        image != null && image!.path != currentUser.imageUrl;
  }
}
