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
      navigateAfterSeconds: const Home(),
      title: const Text(
        "Flower Recorgniser",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      image: Image.asset('assets/flower.png'),
      photoSize: 120.0,
      gradientBackground: const LinearGradient(
        colors: [Color(0xFFA8E063), Color(0xFF56AB2F)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.004, 1],
      ),
      loaderColor: Colors.white,
    );
  }
}
