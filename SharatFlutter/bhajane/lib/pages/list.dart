import 'package:flutter/material.dart';

class MyAppListView extends StatefulWidget {
  @override
  _MyAppListViewState createState() => _MyAppListViewState();
}

class _MyAppListViewState extends State<MyAppListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Bhajane App"),
        centerTitle: false,
        leading: Icon(Icons.music_note),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Bhajane"),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
