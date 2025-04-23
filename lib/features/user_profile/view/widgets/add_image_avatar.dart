import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/user_profile/view/widgets/image_avatar.dart';
import 'package:flutter/material.dart';

class AddImageAvatar extends StatelessWidget {
  const AddImageAvatar(
      {super.key, required this.userModel, this.onTap, this.image});
  final UserModel userModel;
  final void Function()? onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ImageAvatar(
            image: image, gender:userModel.gender ?? ""),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.add_a_photo, color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    );
  }
}
