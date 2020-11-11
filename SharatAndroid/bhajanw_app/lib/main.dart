import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyAppListView(),
  ));
}

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
              title: Text(
                "Song1",
                style: TextStyle(
                  fontFamily: "VictorMono",
                  fontSize: 16,
                ),
              ),
              // On tap goes to listOnTap() function
              onTap: () {
                listOnTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}

listOnTap() {}
