import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class InfoBody extends StatelessWidget {
  const InfoBody({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          readOnly: true,
          controller: TextEditingController(text: userModel.email),
          validator: (value) {
            return null;
          },
          label: "Email",
          icon: Icons.email,
        ),
        SizedBox(height: 20),
        CustomTextField(
          readOnly: true,
          validator: (value) {
            return null;
          },
          controller: TextEditingController(text: userModel.id),
          label: "Student ID",
          icon: Icons.confirmation_number,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                readOnly: true,
                validator: (value) {
                  return null;
                },
                controller: TextEditingController(text: userModel.level ?? ""),
                label: "Level",
                icon: Icons.school,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                readOnly: true,
                validator: (value) {
                  return null;
                },
                controller: TextEditingController(text: userModel.gender ?? ""),
                label: "Gender",
                icon: Icons.person,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
