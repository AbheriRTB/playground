import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_what/pages/home/add.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/utils/lists.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.indigo[100],
                ),
              ),
            ],
          ),
          color: Colors.indigo,
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPage()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "HOME",
                    style: TextStyle(
                        fontSize: 44,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) => CustomList.home(
                            what: "What?",
                            where: "Where?",
                          )),
                ),
              ],
            ),
          ),
        ));
  }
}
