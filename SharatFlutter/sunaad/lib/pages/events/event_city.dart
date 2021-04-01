import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/expanded.dart';

class EventCityPage extends StatefulWidget {
  @override
  _EventCityPageState createState() => _EventCityPageState();
}

class _EventCityPageState extends State<EventCityPage> {
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
        pos: 6,
      ),
      body: Container(
        child: ExpandableListTile(
          index: 4,
          imageThere: false,
        ),
      ),
    );
  }
}
