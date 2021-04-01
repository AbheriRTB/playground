import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/expanded.dart';

class EventArtistePage extends StatefulWidget {
  @override
  _EventArtistePageState createState() => _EventArtistePageState();
}

class _EventArtistePageState extends State<EventArtistePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Artists",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: MyDrawer(
          pos: 2,
        ),
        body: Container(
          child: ExpandableListTile(
            index: 0,
            imageThere: true,
          ),
        ));
  }
}
