import 'package:flutter/material.dart';
import 'package:i_did/pages/dash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_did/pages/example.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.bebasNeue().fontFamily),
    );
  }
}
