import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/widgets/custom_button.dart';
import 'package:fcai_app/features/authentication/view/login_view.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:fcai_app/features/user_profile/view/change_password.dart';
import 'package:fcai_app/features/user_profile/view/user_edit_info.dart';
import 'package:fcai_app/features/user_profile/view/widgets/custom_app_bar.dart';
import 'package:fcai_app/features/user_profile/view/widgets/image_avatar.dart';
import 'package:fcai_app/features/user_profile/view/widgets/info_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserProvider>(context).currentUser;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
        child: Column(
          children: [
            CustomAppBar(
                iconL: Icons.logout_outlined,
                iconR: Icons.edit_note_rounded,
                onPressedL: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                },
                onPressedR: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserEditInfo(),
                    ),
                  );
                }),
            ImageAvatar(
              image: userModel.imageUrl,
              gender: userModel.gender ?? "",
            ),
            const SizedBox(height: 20),
            Text(
              userModel.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(height: 60),
            InfoBody(userModel: userModel),
            const SizedBox(height: 60),
            CustomButton(
              label: "Change password",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
              },
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
