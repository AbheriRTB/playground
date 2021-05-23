import 'package:bhajane/pages/select.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    void splash() async => await Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SelectPage()));
        });
    splash();
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Image.asset(
          'lib/assets/images/lord-rama.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
