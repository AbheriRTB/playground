import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunaad/pages/splash.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = Color(0xFF900C3F),
      accentColor = Color(0xFFFF5733),
      primaryColorLight = Color(0xFFC70039);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getColor(),
        builder: (context, snapshot) {
          if (snapshot.data == 'deepPurple') {
            primaryColor = Colors.deepPurple;
            primaryColorLight = Colors.deepPurpleAccent;
            accentColor = Colors.orange;
          }
          if (snapshot.data == 'orange') {
            primaryColor = Colors.orange;
            primaryColorLight = Colors.orangeAccent;
            accentColor = Colors.green;
          }
          if (snapshot.data == 'lightGreen') {
            primaryColor = Colors.lightGreen[700];
            primaryColorLight = Colors.lightGreen;
            accentColor = Colors.orange;
          }
          if (snapshot.data == 'cyan') {
            primaryColor = Colors.cyan[600];
            primaryColorLight = Colors.cyan;
            accentColor = Colors.blue[700];
          }

          return MaterialApp(
              theme: ThemeData(
                primaryColor: primaryColor,
                primaryColorLight: primaryColorLight,
                accentColor: accentColor,
              ),
              debugShowCheckedModeBanner: false,
              home: SplashPage());
        });
  }

  Future<String> _getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String color;
    color = prefs.getString('color');
    return color;
  }
}
