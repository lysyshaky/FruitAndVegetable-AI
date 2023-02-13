import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: const Text(
        "Fruit & Vegetable Recogniser",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      image: Image.asset('assets/fruit.png'),
      photoSize: 120.0,
      gradientBackground: const LinearGradient(
        colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.004, 1],
      ),
      loaderColor: Colors.white,
    );
  }
}
