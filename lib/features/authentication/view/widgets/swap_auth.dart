import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SwapAuth extends StatelessWidget {
  const SwapAuth(
      {super.key,
      required this.label,
      required this.action,
      required this.onPressed});
  final String label;
  final String action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xff757575), fontSize: 14),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            action,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
