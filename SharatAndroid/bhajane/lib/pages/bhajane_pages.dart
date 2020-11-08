import 'package:bhajane/utils.dart';
import 'package:flutter/material.dart';

class MyAppBhajaneOne extends StatefulWidget {
  @override
  _MyAppBhajaneTwoState createState() => _MyAppBhajaneTwoState();
}

class _MyAppBhajaneTwoState extends State<MyAppBhajaneTwo> {
  bhajane shloka = bhajane(lyrics: "lyrics", name: "name", code: "#102AB");

  @override
  Widget build(BuildContext context) {
    return Shloka(
      shloka: shloka,
    );
  }
}

class MyAppBhajaneTwo extends StatefulWidget {
  @override
  _MyAppBhajaneTwoState createState() => _MyAppBhajaneTwoState();
}

class _MyAppBhajaneThreeState extends State<MyAppBhajaneTwo> {
  bhajane shloka = bhajane(lyrics: "lyrics", name: "name", code: "#102AB");

  @override
  Widget build(BuildContext context) {
    return Shloka(
      shloka: shloka,
    );
  }
}

class MyAppBhajaneThree extends StatefulWidget {
  @override
  _MyAppBhajaneThreeState createState() => _MyAppBhajaneThreeState();
}

class _MyAppBhajaneOneState extends State<MyAppBhajaneThree> {
  bhajane shloka = bhajane(lyrics: "lyrics", name: "name", code: "#102AB");

  @override
  Widget build(BuildContext context) {
    return Shloka(
      shloka: shloka,
    );
  }
}
