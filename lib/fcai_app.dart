import 'package:fcai_app/features/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';

class FCAIApp extends StatelessWidget {
  const FCAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UserProfile(),
    );
  }
}
