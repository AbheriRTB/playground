import 'package:flutter/material.dart';
import 'package:kaksha/pages/page_splash.dart';
import 'package:kaksha/pages/page_subashita.dart';

void main() {
  Color accent = Color.fromRGBO(218, 117, 68, 1);
  Color primary = Color.fromRGBO(233, 229, 205, 1);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
    theme: ThemeData(
      fontFamily: 'Courier',
      accentColor: accent,
      primaryColor: primary,
    ),
  ));
}
