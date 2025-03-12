// import 'package:fcai_app/core/widgets/custom_button.dart';
// import 'package:fcai_app/features/user_profile/view/widgets/custom_app_bar.dart';
// import 'package:fcai_app/features/user_profile/view/widgets/image_avatar.dart';
// import 'package:fcai_app/features/user_profile/view/widgets/info_body.dart';
// import 'package:flutter/material.dart';

// class UserProfile extends StatelessWidget {
//   const UserProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xffF5F5F5),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
//             child: Column(
//               children: [
//                 CustomAppBar(),
//                 const SizedBox(height: 0),
//                 ImageAvatar(
//                   gender: "Male",
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Aly Khaled',
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Poppins"),
//                 ),
//                 const SizedBox(height: 40),
//                 InfoBody(),
//                 const SizedBox(height: 60),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: CustomButton(
//                     label: "Change Password",
//                     onPressed: () {},
//                     color: 0xff4FA085,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
