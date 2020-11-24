import 'package:bhajane/pages/list.dart';
import 'package:bhajane/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ListPage(),
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => SplashPage(),
      "/list": (context) => ListPage(),
      //"/Bhajane": (context) => ListPage(),
    },
  ));
}
