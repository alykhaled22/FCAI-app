import 'package:fcai_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class InfoBody extends StatelessWidget {
  const InfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Email",
          icon: Icons.email,
        ),
        SizedBox(height: 20),
        CustomTextField(
          label: "ID",
          icon: Icons.confirmation_number,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: "Level",
                icon: Icons.school,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
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
