import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_what/models/what.dart';
import 'package:where_what/pages/home/add.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/services/database.dart';
import 'package:where_what/utils/wherelist.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final AuthService _auth = AuthService();

  String uid;
  @override
  Widget build(BuildContext context) {
    Future<void> getID() async {
      uid = await _auth.getUID();
      setState(() {});
    }

    getID();

    return StreamProvider<List<What>>.value(
      value: DatabaseService(uid: uid).users,
      child: Scaffold(
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
                    color: Colors.red[100],
                  ),
                ),
              ],
            ),
            color: Colors.red,
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("Add"),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AddPage()));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          body: AnnotatedRegion(
            value: SystemUiOverlayStyle.dark,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Expanded(child: WhereList()),
                ],
              ),
            ),
          )),
    );
  }
}
