import 'package:fcai_app/features/authentication/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffF5F5F5),
    systemNavigationBarColor: Color(0xffF5F5F5),
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const FCAIApp());
}

class FCAIApp extends StatelessWidget {
  const FCAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}
