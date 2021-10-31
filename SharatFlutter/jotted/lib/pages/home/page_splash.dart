import 'package:jotted/models/model_user.dart';

import 'package:jotted/wrapper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    splash() async {
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
        );
      });
    }

    splash();
    //splash();
    return Scaffold();
  }
}
