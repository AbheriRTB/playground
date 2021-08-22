import 'package:flutter/material.dart';
import 'package:protrack/models/subject.dart';
import 'package:protrack/utils/cheboxState.dart';
import 'package:protrack/utils/subjChek.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<CheckboxState> topics = [
    CheckboxState(title: "title"),
    CheckboxState(title: "title")
  ];

  bool val = false;

  final allList = CheckboxState(title: "SELECT ALL");

  final list = [
    CheckboxState(title: "ABC1"),
    CheckboxState(title: "ABC2"),
    CheckboxState(title: "ABC3"),
    CheckboxState(title: "ABC4"),
  ];
  @override
  Widget build(BuildContext context) {
    List<SubjChek> subjects = [SubjChek(false, "subjects", topics: topics)];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Select Topic",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
          //children: [buildList(topics, subjects)],
          ),
    );
  }

  Widget buildSingleCheckbox(CheckboxState checkbox) => CheckboxListTile(
        title: Text(checkbox.title),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox.val,
        onChanged: (value) {
          setState(() {
            checkbox.val = value;
            allList.val = list.every((element) => element.val);
          });
        },
      );
  Widget buildGroupCheckbox(CheckboxState checkbox) => CheckboxListTile(
        title: Text(checkbox.title),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox.val,
        onChanged: toggleGroupCheckbox,
      );

  void toggleGroupCheckbox(bool val) {
    if (val == null) return;

    setState(() {
      allList.val = val;
      list.forEach((element) {
        element.val = val;
      });
    });
  }

  buildList(
    List<CheckboxState> topics,
    List<CheckboxState> subjects,
  ) {
    return Column(
      children: [
        ...subjects.map(buildGroupCheckbox).toList(),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            children: [
              ...topics.map(buildSingleCheckbox).toList(),
            ],
          ),
        ),
        // buildGroupCheckbox(subjects),
        // Padding(
        //   padding: const EdgeInsets.only(left: 24.0),
        //   child: Column(
        //     children: [
        //       ...list.map(buildSingleCheckbox).toList(),
        //     ],
        //   ),
        // ),
        // Divider(),
      ],
    );
  }
}
