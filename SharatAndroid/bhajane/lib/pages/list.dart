import 'dart:html';

import 'package:flutter/material.dart';

class MyAppListView extends StatefulWidget {
  @override
  _MyAppListViewState createState() => _MyAppListViewState();
}

class _MyAppListViewState extends State<MyAppListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // AppBar
        appBar: AppBar(
          backgroundColor: Colors.lime,
          title: Text(
            "Bhajane",
            style: TextStyle(fontFamily: "VictorMono"),
          ),
          leading: Icon(Icons.ac_unit),
        ),
        body: ListView(
          children: [
            // List
            ListTile(
              leading: Icon(Icons.landscape),
              title: Text(
                "Song1",
                style: TextStyle(
                  fontFamily: "VictorMono",
                  fontSize: 16,
                ),
              ),
              subtitle: Text("-Artist1"),
              // On tap goes to listOnTap() function
              onTap: () {
                listOnTap();
              },
            ),
            Divider(
              endIndent: 5,
            ),
          ],
        ),
      ),
    );
  }
}

listOnTap() {}
