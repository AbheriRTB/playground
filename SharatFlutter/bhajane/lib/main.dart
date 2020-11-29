import 'package:bhajane/pages/bhajane.dart';
import 'package:bhajane/pages/list.dart';
import 'package:bhajane/pages/settings.dart';
import 'package:bhajane/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => SplashPage(),
      "/list": (context) => ListPage(),
      "/bhajane": (context) => BhjanePage(),
      "/settings": (context) => SettingsPage(),
    },
  ));
}
