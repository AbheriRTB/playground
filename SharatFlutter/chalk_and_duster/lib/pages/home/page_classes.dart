import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:chalk_and_duster/models/model_message.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/pages/home/page_grup_msgs.dart';
import 'package:chalk_and_duster/pages/home/pages_add_group.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:chalk_and_duster/widgets/widget_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool? isAdmin = false, isTeacher = false;

  @override
  Widget build(BuildContext context) {
    UsersData user = Provider.of<UsersData>(context);
    print(user.uid);
    return StreamProvider<List<Groups>>.value(
      value: DatabaseService(
        orgId: user.orgId,
        uid: user.uid,
      ).groupsList,
      child: ClassesPageMobile(auth: _auth, user: user),
      initialData: [],
      catchError: null,
    );
  }
}

class ClassesPageMobile extends StatelessWidget {
  const ClassesPageMobile({
    Key? key,
    required AuthService auth,
    required this.user,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;
  final UsersData user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          user.displayName!,
          style: TextStyle(
            fontFamily: 'Integral',
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().signOut();
            },
            icon: Icon(
              Icons.search,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                elevation: 2,
                shadowColor: Colors.grey[200],
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {
                          _auth.signOut();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black87.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        'Search in spaces',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      CircleAvatar(
                        maxRadius: 14.0,
                        foregroundImage: user.photoUrl!.isNotEmpty
                            ? NetworkImage(user.photoUrl!)
                            : NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png'),
                        backgroundColor: Colors.grey[100],
                        child: Text(user.displayName![0],
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.grey[600])),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),*/

            Expanded(
              child: GroupsListView(
                usersData: user,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: user.isAdmin!
          ? FloatingActionButton.extended(
              label: Text(
                'New class'.toUpperCase(),
                style: TextStyle(color: Colors.green),
              ),
              icon: Icon(
                Icons.add,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddGroupPage(),
                    ));
              },
              backgroundColor: Colors.white,
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class GroupsListView extends StatelessWidget {
  GroupsListView({
    Key? key,
    required this.usersData,
  });

  UsersData usersData;

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<List<Groups>>(context);

    return groups.isNotEmpty
        ? ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return StreamBuilder<List<Messages>>(
                  stream: DatabaseService(
                    grupId: groups[index].grupId,
                    orgId: usersData.orgId,
                  ).messagesData,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container();
                    }
                    List<Messages> data = snapshot.data!;
                    bool isRead = false;

                    if (data.isNotEmpty) {
                      isRead = !data.first.readUsers!.contains(usersData.uid);
                    }

                    return CustomList.listTypeOne(
                      name: groups[index].grupName ?? '',
                      isRead: isRead,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupMessagesPage(
                                grups: groups[index],
                                userData: usersData,
                              ),
                            ));
                      },
                      color: groups[index].photoColor,
                    );
                  });
            })
        : Center(
            child: CircularProgressIndicator(
            color: Color(0xff90D44B),
          ));
  }
}
