import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:protrack/utils/list.dart';

class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
              child: Text(
                "Goals",
                style: TextStyle(fontSize: 42, color: Colors.grey[600]),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => CustomList.goal(
                        goal: "New Goal",
                        prog: 98,
                      )),
            ),
          ],
        ),
      ),

      // App Bar
      bottomNavigationBar: new BottomAppBar(
        color: Colors.lime,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
