import 'package:flutter/material.dart';
import 'package:where_what/models/user.dart';
import 'package:where_what/pages/auth/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:where_what/pages/home/list.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return ListPage();
    }
  }
}
