import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trench/models/model_user.dart';
import 'package:trench/pages/auth/authenticate.dart';
import 'package:trench/pages/home/home.dart';

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
      return Home();
    }
  }
}
