import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/features/authentication/view/login_view.dart';
import 'package:fcai_app/features/user_profile/view/user_edit_profile.dart';
import 'package:fcai_app/features/user_profile/view/widgets/custom_button.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:fcai_app/features/user_profile/view/change_password.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
        child: Column(
          children: [
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
            const SizedBox(height: 40),
            InfoBody(userModel: userModel),
            const SizedBox(height: 60),
            CustomButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: "Edit Profile",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserEditProfile(),
                  ),
                );
              },
              buttonColor: AppColors.primaryColor,
            ),
            SizedBox(height: 20),
            CustomButton(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.black,
              ),
              label: "Change password",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
              },
              buttonColor: Colors.white,
              textColor: Colors.black,
            ),
            SizedBox(height: 20),
            CustomButton(
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              label: "Logout",
              onPressed: () async {
                final desicion = await Helpers.alertDialog(
                  context,
                  icon: Icon(Icons.logout, size: 36, color: Colors.red),
                  title: "Logout Confirmation",
                  message: "Are you sure you want to logout?",
                  actionText: "Logout",
                  buttonColor: Colors.red,
                );

                if (desicion == true) {
                  if (!context.mounted) return;
                  Provider.of<UserProvider>(context, listen: false)
                      .logoutUser();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ));
                }
              },
              buttonColor: Colors.white,
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
