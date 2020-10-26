
import 'package:flutter/material.dart';


class MyAppListView extends StatefulWidget {
  @override
  _MyAppListViewState createState() => _MyAppListViewState();
}

class _MyAppListViewState extends State<MyAppListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.landscape),
          title: Text("Song1"),
          subtitle: Text("-Artist1")
        ),
        Divider(
          endIndent: 5,
        ),
      ],
    );
  }
}