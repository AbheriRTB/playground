import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) => runApp(Material());

class Meetings {
  String name, link, meet;
  int year, month, date, hour, minute;

  Meetings(
      {this.name,
      this.meet,
      this.meet,
      this.year,
      this.date,
      this.hour,
      this.minute});
}

class MeetingsWindow extends StatefulWidget {
  @override
  _MeetingsWindowState createState() => _MeetingsWindowState();
}

class _MeetingsWindowState extends State<MeetingsWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}