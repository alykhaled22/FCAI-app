import 'package:fcai_app/features/user_profile/view/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icons.logout_outlined),
        CustomIconButton(
          onPressed: () {},
          icon: Icons.edit_note_rounded,
        ),
      ],
    );
  }
}
