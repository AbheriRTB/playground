import 'dart:ui';

import 'package:bhajane/pages/list.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


class MyAppSplash extends StatefulWidget {
  @override
  _MyAppSplashState createState() => _MyAppSplashState();
}

class _MyAppSplashState extends State<MyAppSplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.white60,
      image: Image.asset('lib/assets/Rama.jpg'),
      photoSize: 500.0,
      loadingText: Text("Bhajane"),
      navigateAfterSeconds: MyAppListView,
    );
  }
}