import 'package:flutter/material.dart';
import 'package:protrack/pages/views/addGoal.dart';
import 'package:protrack/pages/views/addSubject.dart';
import 'package:protrack/pages/views/addTopic.dart';
import 'package:protrack/pages/views/goal.dart';
import 'package:protrack/pages/views/subjects.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/utils/user_lists.dart';
import 'package:protrack/utils/widgets/recents.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        // Main

        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 56, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0),
                child: Text(
                  "Recents",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RecentContainer(),
              ),
            ],
          ),
        ),

        // AppBar
        bottomNavigationBar: new BottomAppBar(
          color: Colors.lime,

          // Menu
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onSelected: (result) {
                    if (result == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddGoalPage()),
                      );
                    }
                    if (result == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSubjectPage()),
                      );
                    }
                    if (result == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTopicPage()),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        leading: Icon(Icons.flag),
                        title: Text('Add Goal'),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.anchor),
                        title: Text('Add Subject'),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.article),
                        title: Text('Add Topic'),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectListPage()));
                  },
                  icon: Icon(
                    Icons.handyman_rounded,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Anchor
          shape: CircularNotchedRectangle(),
        ),

        // Fab
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GoalPage()));
          },
          child: Icon(Icons.menu_book_rounded),
          backgroundColor: Colors.red,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
