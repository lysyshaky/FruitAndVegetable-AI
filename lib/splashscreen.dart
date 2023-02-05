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
      title: Text("Dog and Cat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xFFE99600),),),
      image: Image.asset('assets/cat.png'),
      backgroundColor: Colors.black,
      loaderColor: Color(0xFFEEDA28),
    );
  }
}
