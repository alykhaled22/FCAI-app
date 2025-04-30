import 'package:fcai_app/core/view/app_navigation.dart';
import 'package:fcai_app/features/authentication/view/login_view.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      bool isLoggedIn = await Provider.of<UserProvider>(context, listen: false)
          .checkLoginState();

      if (isLoggedIn) {
        if (!mounted) return;
        Provider.of<UserProvider>(context, listen: false).loadCurrentUser();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AppNavigation()));
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/splash.png",
              width: 300,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 170,
            child: LottieBuilder.asset(
              "assets/lotties/splash_hat.json",
              width: 200,
            ),
          ),
          Positioned(
            top: 10,
            child: LottieBuilder.asset("assets/lotties/splash_fireworks.json"),
          ),
          Positioned(
            top: 490,
            child: Text(
              "2025 Senior",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "GT Sectra Fine",
                  color: Colors.green),
            ),
          )
        ],
      ),
    );
  }
}
