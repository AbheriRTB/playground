import 'package:chalk_and_duster/models/user.dart';
import 'package:chalk_and_duster/pages/home/page_grup_msgs.dart';
import 'package:chalk_and_duster/pages/home/pages_add_group.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:chalk_and_duster/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  Users? users;

  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool? isAdmin = false, isTeacher = false;
  String? uid;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);

    return StreamProvider<UsersData>.value(
      value: DatabaseService(uid: users!.uid).userData,
      builder: (context, snapshot) {
        UsersData? user;

        user = Provider.of<UsersData>(context);

        return Scaffold(
          backgroundColor: primary,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          minRadius: 16.0,
                          backgroundColor: secondary,
                          child: Text(
                            '${user.displayName![0]}',
                            style: TextStyle(color: accentDark),
                          ),
                        ),
                        Text(
                          'Class Rooms',
                          style: TextStyle(
                            fontSize: 32.0,
                            color: accentDark,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _auth.signOut();
                          },
                          icon: Icon(
                            Icons.search,
                            color: accentDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GroupsListView(
                    auth: _auth,
                    context: context,
                    user: user,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: user.isAdmin!
              ? FloatingActionButton.extended(
                  label: Text('Add'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddGroupPage(),
                        ));
                  },
                  backgroundColor: secondary,
                )
              : Container(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
      initialData: UsersData.initialData(),
      catchError: null,
    );
  }
}

class GroupsListView extends StatelessWidget {
  GroupsListView({
    Key? key,
    required AuthService auth,
    required this.context,
    required this.user,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;
  final context;
  UsersData user;

  @override
  Widget build(BuildContext context) {
    print(user.email);
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService(orgId: user.orgId, uid: user.uid).grupData,
        builder: (context, snapshot) {
          print(snapshot);
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data!.size : 0,
                itemBuilder: (context, index) {
                  return CustomList.listTypeOne(
                    name: snapshot.data!.docs[index]['groupName'],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupMessagesPage(
                              grupId: snapshot.data!.docs[index].id,
                              orgId: user.orgId!,
                              userData: user,
                            ),
                          ));
                    },
                  );
                }),
          );
        });
  }
}
