import 'package:flutter/material.dart';
import 'package:kaksha/pages/page_subashita.dart';
import 'package:kaksha/wrapper.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void splash() async => await Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Wrapper()));
        });
    splash();
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.format_quote_rounded,
          size: 64.0,
          color: Color.fromRGBO(218, 117, 68, 1),
        ),
      ),
      backgroundColor: Color.fromRGBO(253, 246, 227, 1),
    );
  }
}
