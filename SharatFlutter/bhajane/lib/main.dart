import 'package:bhajane/pages/select.dart';
import 'package:bhajane/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhajane',
      theme: ThemeData(
        fontFamily: GoogleFonts.balooTamma().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: SelectPage(),
    );
  }
}
