import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';

class DictionaryOrganizerPage extends StatefulWidget {
  @override
  _DictionaryOrganizerPageState createState() =>
      _DictionaryOrganizerPageState();
}

class _DictionaryOrganizerPageState extends State<DictionaryOrganizerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Organizer",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        pos: 9,
      ),
      body: Container(
        child: Center(child: Text("Organizer")),
      ),
    );
  }
}
