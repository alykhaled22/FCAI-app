import 'package:fcai_app/features/authentication/view/login_view.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FCAIApp extends StatelessWidget {
  const FCAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
