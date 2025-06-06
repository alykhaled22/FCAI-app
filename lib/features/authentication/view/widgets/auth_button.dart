import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/authentication/view/widgets/loading_holder.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonColor = AppColors.primaryColor,
    this.buttonTextColor = Colors.white,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: buttonColor,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? LoadingHolder()
            : Text(
                label,
                style: TextStyle(
                    color: buttonTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
