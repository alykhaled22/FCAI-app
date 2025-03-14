import 'package:fcai_app/features/user_profile/view/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.iconR, required this.iconL, required this.onPressedR, required this.onPressedL});
  final IconData iconR;
  final IconData iconL;
  final Function() onPressedR;
  final Function() onPressedL;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
            onPressed: onPressedL,
            icon: iconL),
        CustomIconButton(
          onPressed: onPressedR,
          icon: iconR,
          // icon: Icons.edit_note_rounded,
        ),
      ],
    );
  }
}
