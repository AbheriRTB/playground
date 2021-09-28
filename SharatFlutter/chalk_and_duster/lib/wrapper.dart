import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/nav_bar.dart';
import 'package:chalk_and_duster/pages/auth/authenticate.dart';
import 'package:chalk_and_duster/pages/home/page_splash.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<UsersData>.value(
        initialData: UsersData.initialData(),
        value: DatabaseService(uid: user.uid).userData,
        child: NavBar(),
      );
    }
  }
}
