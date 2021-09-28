import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/nav_bar.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
            builder: (context) => NavBar(),
          ),
        );
      });
    }

    splash();
    //splash();
    return Scaffold();
  }
}
