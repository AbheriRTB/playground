import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/expanded.dart';
import 'package:sunaad/utils/list_tile.dart';
import 'package:sunaad/models/orgs.dart';
import 'package:sunaad/models/programs.dart';

class EventOrganizerPage extends StatefulWidget {
  @override
  _EventOrganizerPageState createState() => _EventOrganizerPageState();
}

class _EventOrganizerPageState extends State<EventOrganizerPage> {
  List<Programs> progs;

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
        pos: 4,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8.0),
        child: ExpandableListTile(
          index: 2,
          imageThere: false,
        ),
      ),
    );
  }
}

//
