import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HolderBody extends StatelessWidget {
  const HolderBody({
    super.key,
    required this.icon,
    required this.message,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });
  final Icon icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: AppColors.primaryColorWithOpacity,
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
