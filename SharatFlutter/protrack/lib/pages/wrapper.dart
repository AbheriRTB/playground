import 'package:flutter/material.dart';
import 'package:protrack/models/user.dart';
import 'package:protrack/pages/auth/authenticate.dart';
import 'package:protrack/pages/views/dashboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return DashBoard();
    }
  }
}
