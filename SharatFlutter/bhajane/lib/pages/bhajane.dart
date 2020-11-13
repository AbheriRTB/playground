import 'package:flutter/material.dart';

class MyAppBhajane extends StatefulWidget {
  @override
  _MyAppBhajaneState createState() => _MyAppBhajaneState();
}

class _MyAppBhajaneState extends State<MyAppBhajane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Bhajane will display Here",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
