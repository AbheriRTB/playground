import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/expanded.dart';
import 'package:sunaad/utils/list_tile.dart';

class EventTypePage extends StatefulWidget {
  @override
  _EventTypePageState createState() => _EventTypePageState();
}

class _EventTypePageState extends State<EventTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Concerts",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        pos: 5,
      ),
      body: Container(
        child: ExpandableListTile(
          index: 3,
          imageThere: false,
        ),
      ),
    );
  }
}
