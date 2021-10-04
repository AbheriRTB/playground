import 'package:animations/animations.dart';
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
        orgId: user.orgId ?? ' ',
        uid: user.uid ?? ' ',
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
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            'Classes',
            style: TextStyle(
              fontFamily: 'Integral',
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.grey[800],
          ),
          splashColor: Colors.grey[900]!.withOpacity(0.5),
          highlightColor: Colors.grey[900]!.withOpacity(0.5),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.grey[800],
            ),
            splashColor: Colors.grey[900]!.withOpacity(0.5),
            highlightColor: Colors.grey[900]!.withOpacity(0.5),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[800],
            ),
            color: Colors.grey[900],
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddGroupPage(),
                      ));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'New Group',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(
                    Icons.anchor,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'New Note',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  AuthService().signOut();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.4, -0.8),
            stops: [0.0, 0.5, 0.5, 1],
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.grey[900]!.withOpacity(0.2),
              Colors.grey[900]!.withOpacity(0.2),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SafeArea(
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
      ),
      floatingActionButton: user.isAdmin!
          ? FloatingActionButton.extended(
              label: Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  'New note'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Integral',
                    color: Colors.grey[900],
                  ),
                ),
              ),
              icon: Icon(
                Icons.add,
                color: Colors.grey[900],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddGroupPage(),
                    ));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              //backgroundColor: Colors.white,
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class GroupsListView extends StatelessWidget {
  GroupsListView({
    Key? key,
    required this.usersData,
  });
  final transitionType = ContainerTransitionType.fade;

  UsersData usersData;

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<List<Groups>>(context);
    groups.sort((a, b) {
      var adate = a.lastMessage!['timeStamp'];
      var bdate = b.lastMessage!['timeStamp'];
      return -adate.compareTo(bdate);
    });

    return groups.isNotEmpty
        ? ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) => OpenContainer(
              closedColor: Colors.transparent,
              openColor: Colors.grey[900]!,
              transitionType: transitionType,
              transitionDuration: Duration(milliseconds: 200),
              openBuilder: (context, _) => GroupMessagesPage(
                grups: groups[index],
                userData: usersData,
              ),
              closedBuilder: (context, VoidCallback openContainer) =>
                  ListWidget(groups, index, openContainer),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
            color: Color(0xff90D44B),
          ));
  }

  Widget ListWidget(List<Groups> groups, int index, VoidCallback? onTap) {
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
            grupData: groups[index],
            onTap: onTap,
            color: groups[index].photoColor,
          );
        });
  }
}
