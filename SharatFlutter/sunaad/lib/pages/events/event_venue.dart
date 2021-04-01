import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/expanded.dart';
import 'package:sunaad/utils/list_tile.dart';

class EventVenuePage extends StatefulWidget {
  @override
  _EventVenuePageState createState() => _EventVenuePageState();
}

class _EventVenuePageState extends State<EventVenuePage> {
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
        pos: 3,
      ),
      body: Container(
        child: ExpandableListTile(
          index: 1,
          imageThere: false,
        ),
      ),
    );
  }
}
