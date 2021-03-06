import 'package:flutter/material.dart';
import 'package:protrack/pages/views/add.dart';
import 'package:protrack/pages/views/goal.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/utils/user_lists.dart';

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
              UserLists(),
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
                IconButton(
                  onPressed: () async {
                    String uid = await AuthService().getUID();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddPage()));
                    /*await DatabaseService(uid: uid).createGoal(
                        "goalName", "discription", 10, "durationUnit");*/
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
