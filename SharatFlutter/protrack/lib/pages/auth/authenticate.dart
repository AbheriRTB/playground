import 'package:flutter/material.dart';
import 'package:protrack/pages/auth/register.dart';
import 'package:protrack/pages/auth/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView: toggleView);
    } else {
      return RegisterPage(toggleView: toggleView);
    }
  }
}
