import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Bhajane"),
        leading: Icon(Icons.music_note),
        centerTitle: false,
      ),
      body: ListView(
        children: [ListTile()],
      ),
    );
  }
}
