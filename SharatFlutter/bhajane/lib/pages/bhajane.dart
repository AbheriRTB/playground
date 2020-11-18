import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAppBhajane extends StatefulWidget {
  @override
  _MyAppBhajaneState createState() => _MyAppBhajaneState();
}

class _MyAppBhajaneState extends State<MyAppBhajane> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.arrow_right),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        onPressed: () {
          Fluttertoast.showToast(msg: "You Clicket it!");
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Bhajane",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                "Lyrics will be dysplayed here",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
