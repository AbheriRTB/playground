import 'package:flutter/material.dart';

class MeetingsPage extends StatefulWidget {
  @override
  _MeetingsPageState createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Meeting"),
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Google Duo Meet"),
            subtitle: Text("This is a google duo meeting sheduled"),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
