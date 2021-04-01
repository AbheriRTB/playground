import 'package:flutter/material.dart';
import 'package:sunaad_pen/pages/public/add.dart';
import 'package:sunaad_pen/services/auth.dart';

class Pages233 extends StatefulWidget {
  @override
  _Pages233State createState() => _Pages233State();
}

class _Pages233State extends State<Pages233> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text('Log Out'),
              color: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
              },
              child: Text('AddPage'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
