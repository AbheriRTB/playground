import 'package:jotted/models/model_user.dart';
import 'package:jotted/pages/auth/page_sign_in.dart';
import 'package:jotted/pages/home/classes/page_classes.dart';
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
      return SignInPage();
    } else {
      return const ClassesPage();
    }
  }
}
