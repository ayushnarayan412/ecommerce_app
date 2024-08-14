import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/screens/sign_up_page.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool _startSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _startSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_startSplash) {
      return const SplashScreen();
    }
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const SignUpPage();
        }
      },
    );
  }
}
