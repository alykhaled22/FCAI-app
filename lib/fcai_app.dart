import 'package:fcai_app/fcai_app_navigation.dart';
import 'package:fcai_app/features/authentication/view/login_view.dart';
import 'package:fcai_app/features/stores/view/fav_stores_view.dart';
import 'package:flutter/material.dart';

class FCAIApp extends StatelessWidget {
  const FCAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FcaiAppNavigation(),
    );
  }
}
