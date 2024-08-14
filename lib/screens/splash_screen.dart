import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecommerce_app/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    super.initState();
    const SplashScreen();
    Timer(const Duration(seconds: 3), () {
    });
  }
  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
          splash: const Image(
              image: AssetImage('assets/images/logo.jpg'), fit: BoxFit.cover),
          splashIconSize: 300,
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          animationDuration: const Duration(seconds: 3),
          nextScreen: const SignUpPage(),
    );
  }
}
