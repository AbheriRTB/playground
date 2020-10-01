import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HomeApp()));

class HomeApp extends StatelessWidget {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name),
        Container(
            child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: ("Hello World!"),
                    filled: true,
                    fillColor: Colors.grey[180])),
                    padding: EdgeInsets.all(32),)
      ],
    ));
  }
}
