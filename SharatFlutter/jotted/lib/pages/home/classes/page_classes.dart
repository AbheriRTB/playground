import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jotted/models/model_group.dart';
import 'package:jotted/models/model_message.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/pages/home/classes/page_class_msgs.dart';
import 'package:jotted/pages/home/classes/page_create_class.dart';
import 'package:jotted/pages/home/page_approval.dart';
import 'package:jotted/services/auth.dart';
import 'package:jotted/services/database.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
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

    return user.approved!
        ? StreamProvider<List<Groups>>.value(
            value: DatabaseService(
              orgId: user.orgId ?? ' ',
              uid: user.uid ?? ' ',
            ).groupsList,
            child: ResponsiveBuilder(
              breakpoints: const ScreenBreakpoints(
                  desktop: 600, tablet: 200, watch: 100),
              builder: (context, sizingInfo) =>
                  sizingInfo.isDesktop ? ClassesPageWeb() : ClassesPageMobile(),
            ),
            initialData: [],
            catchError: null,
          )
        : Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Waiting for admin to aprove'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextButton(
                      onPressed: () => AuthService().signOut(),
                      child: Text('Logout'.toUpperCase()),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class ClassesPageMobile extends StatefulWidget {
  ClassesPageMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassesPageMobile> createState() => _ClassesPageMobileState();
}

class _ClassesPageMobileState extends State<ClassesPageMobile> {
  final isSelected = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    UsersData user = Provider.of<UsersData>(context);

    String? subject;
    String? content;
    List<Groups> groups = Provider.of<List<Groups>>(context);

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: ShiftingTabBar(
          color: colorScheme.background,
          tabs: [
            ShiftingTab(
              icon: Icon(
                Icons.inbox,
                size: 24,
                color: colorScheme.onSurface,
              ),
              text: 'Inbox',
            ),
            ShiftingTab(
              icon: Icon(
                Icons.question_answer_rounded,
                size: 24,
                color: colorScheme.onSurface,
              ),
              text: 'Chat',
            ),
            ShiftingTab(
              icon: Icon(
                Icons.school,
                color: colorScheme.onSurface,
                size: 24,
              ),
              text: 'Class',
            ),
            ShiftingTab(
              icon: Icon(
                Icons.work,
                size: 24,
                color: colorScheme.onSurface,
              ),
              text: 'Task',
            ),
            ShiftingTab(
              icon: Icon(
                Icons.settings,
                color: colorScheme.onSurface,
                size: 24,
              ),
              text: 'Prefs',
            ),
          ],
          labelStyle: TextStyle(
            fontSize: 16.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: SafeArea(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    /*ToggleButtons(
                      renderBorder: false,
                      borderRadius: BorderRadius.circular(12.0),
                      constraints: const BoxConstraints(minHeight: 36.0),
                      isSelected: isSelected,
                      onPressed: (index) {
                        setState(() {
                          if (isSelected[index] == false) {
                            isSelected[index] = !isSelected[index];
                          }
                          if (index == 0) {
                            isSelected[1] = false;
                          } else if (index == 1 && isSelected[index]) {
                            isSelected[0] = false;
                          }
                        });
                      },
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('GROUPS'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('BOARD'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    isSelected[0]
                    ?*/
                    Expanded(
                      child: GroupsListView(),
                    )
                    /*: Expanded(
                            child: ListView.builder(
                                itemCount: groups.length,
                                itemBuilder: (context, index2) {
                                  return StreamBuilder<List<Messages>>(
                                      initialData: [],
                                      stream: DatabaseService(
                                              grupId: groups[index2].grupId,
                                              uid: user.uid,
                                              orgId: user.orgId)
                                          .messagesData,
                                      builder: (context, snapshot) {
                                        List<Messages> data = snapshot.data!;
                                        data2.addAll(snapshot.data!);

                                        data2.sort((a, b) {
                                          var adate = a.timeStamp;
                                          var bdate = b.timeStamp;
                                          return -bdate!.compareTo(adate!);
                                        });

                                        return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            shrinkWrap: true,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              bool isRead = false;
                                              if (data2.isNotEmpty) {
                                                isRead = !data2[index]
                                                    .readUsers!
                                                    .contains(user.uid);
                                              }
                                              return StreamBuilder<UsersData>(
                                                  stream: DatabaseService(
                                                          uid: data2[index]
                                                              .uidFrom)
                                                      .userData,
                                                  initialData:
                                                      UsersData.initialData(),
                                                  builder: (context, snapshot) {
                                                    return ListCardWidget2(
                                                      groups: groups[index2],
                                                      message: data2[index],
                                                      isRead: isRead,
                                                      displayName: snapshot
                                                          .data!.displayName!,
                                                    );
                                                  });
                                            });
                                      });
                                })),*/
                  ],
                ),
              ),
              floatingActionButton: user.isAdmin!
                  ? FloatingActionButton.extended(
                      label: Text(
                        'New note'.toUpperCase(),
                      ),
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor:
                                colorScheme.background.withOpacity(0.9),
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 16.0, 16.0, 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text('New Circular'.toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1)),
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    TextField(
                                      onChanged: (val) {
                                        setState(() => subject = val.trim());
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),

                                      decoration: const InputDecoration(
                                        filled: false,
                                        hintText: 'Enter Subject',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                      ),
                                      //keyboardType: TextInputType.phone,
                                      autocorrect: true,
                                      maxLines: 2,
                                    ),
                                    TextField(
                                      onChanged: (val) {
                                        setState(() => content = val.trim());
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),

                                      decoration: const InputDecoration(
                                        filled: false,
                                        hintText: 'Enter Body',
                                        hintStyle: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                      ),
                                      //keyboardType: TextInputType.phone,
                                      autocorrect: true,
                                      maxLines: null,
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: FloatingActionButton(
                                        child: Icon(Icons.push_pin),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    )
                  : Container(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
            ),
            const Scaffold(),
            const Scaffold(),
            const Scaffold(),
            Scaffold(
              body: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context1) => AlertDialog(
                          backgroundColor: colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Center(
                              child: Text(
                            'SIGN OUT',
                            style: TextStyle(
                              fontFamily: GoogleFonts.lekton().fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.0,
                              color: colorScheme.onSurface,
                            ),
                          )),
                          content: Text(
                            'Do you really want to log out?'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.lekton().fontFamily,
                              fontSize: 18.0,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context1),
                              child: Text('Cancel'.toUpperCase()),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AuthService().signOut();
                                Navigator.pop(context1);
                              },
                              child: Text('Logout'.toUpperCase()),
                            ),
                          ],
                        ),
                      );
                    },
                    title: const Center(
                      child: Text('LOG OUT'),
                    ),
                  ),
                  const Divider(),
                  Visibility(
                    visible: user.isAdmin!,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddGroupPage(),
                          ),
                        );
                      },
                      title: Center(
                        child: Text('New Group'.toUpperCase()),
                      ),
                    ),
                  ),
                  Visibility(visible: user.isAdmin!, child: const Divider()),
                  Visibility(
                    visible: user.isAdmin!,
                    child: ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApprovalPage(),
                        ),
                      ),
                      title: Center(
                        child: Text('Approvals'.toUpperCase()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassesPageWeb extends StatefulWidget {
  ClassesPageWeb({Key? key}) : super(key: key);

  @override
  State<ClassesPageWeb> createState() => _ClassesPageWebState();
}

class _ClassesPageWebState extends State<ClassesPageWeb> {
  int _selectedIndex = 0;
  int? _grup = null;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    List<Groups> groups = Provider.of<List<Groups>>(context);

    groups.sort((a, b) {
      var adate = a.lastMessage!['timeStamp'];
      var bdate = b.lastMessage!['timeStamp'];
      return -adate.compareTo(bdate);
    });

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            backgroundColor: colorScheme.background,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedLabelTextStyle: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.inbox_outlined),
                selectedIcon: Icon(Icons.inbox),
                label: Text(
                  'INBOX',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.question_answer_outlined),
                selectedIcon: Icon(Icons.question_answer),
                label: Text('CHAT'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.school_outlined),
                selectedIcon: Icon(Icons.school),
                label: Text('CLASS'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.work_outline),
                selectedIcon: Icon(Icons.work),
                label: Text('TASK'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('CLASS'),
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: Colors.grey.withOpacity(0.05),
          ),
          Expanded(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    groups.isNotEmpty
                        ? Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search in classes',
                                    prefixIcon: Icon(Icons.search),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.zero),
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: groups.length,
                                    itemBuilder: (context, index) =>
                                        NewListWidget(
                                            groups: groups,
                                            index: index,
                                            web: true,
                                            onTap: () =>
                                                setState(() => _grup = index),
                                            context: context),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              'No Groups Yet'.toUpperCase(),
                              style: const TextStyle(),
                            ),
                          ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                    ),
                    Expanded(
                      flex: 5,
                      child: _grup == null
                          ? Container()
                          : GroupMessagesPage(grups: groups[_grup!], web: true),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GroupsListView extends StatelessWidget {
  GroupsListView({
    Key? key,
  });
  final transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<List<Groups>>(context);
    groups.sort((a, b) {
      var adate = a.lastMessage!['timeStamp'];
      var bdate = b.lastMessage!['timeStamp'];
      return -adate.compareTo(bdate);
    });

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return groups.isNotEmpty
        ? ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) => OpenContainer(
              closedColor: colorScheme.background,
              // openColor: Colors.grey[900]!,
              closedElevation: 0,
              transitionType: transitionType,
              transitionDuration: const Duration(milliseconds: 400),
              openBuilder: (context, _) => GroupMessagesPage(
                web: false,
                grups: groups[index],
              ),
              closedBuilder: (context, VoidCallback openContainer) =>
                  NewListWidget(
                      groups: groups,
                      index: index,
                      web: false,
                      onTap: () {},
                      context: context),
            ),
          )
        : Center(
            child: Text(
            'No Groups Yet'.toUpperCase(),
          ));
  }
}

class NewListWidget extends StatelessWidget {
  const NewListWidget({
    Key? key,
    required this.groups,
    required this.index,
    required this.onTap,
    required this.web,
    required this.context,
  }) : super(key: key);

  final List<Groups> groups;
  final int index;
  final bool web;
  final VoidCallback? onTap;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    UsersData usersData = Provider.of<UsersData>(context);

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

          return StreamBuilder<UsersData>(
              stream:
                  DatabaseService(uid: groups[index].lastMessage!['uidFrom'])
                      .userData,
              initialData: UsersData.initialData(),
              builder: (context, snapshot) {
                return web
                    ? ListCardWidgetWeb(
                        groups: groups,
                        index: index,
                        onTap: onTap!,
                        isRead: isRead,
                        displayName: snapshot.data!.displayName!,
                      )
                    : ListCardWidget(
                        groups: groups,
                        index: index,
                        isRead: isRead,
                        displayName: snapshot.data!.displayName!,
                      );
              });
          /*return ListTile(
            title: Text(
              groups[index].grupName!,
              style: TextStyle(
                fontWeight: isRead ? FontWeight.w600 : FontWeight.normal,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              groups[index].lastMessage!['content']!,
              style: TextStyle(
                fontWeight: isRead ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: colorScheme.primaryVariant,
              child: Center(
                child: Text(
                  groups[index].grupName![0],
                  style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            trailing: AnimatedOpacity(
              opacity: isRead ? 1 : 0,
              duration: const Duration(milliseconds: 100),
              child: CircleAvatar(
                maxRadius: 6,
                backgroundColor: colorScheme.secondaryVariant,
              ),
            ),
            onTap: onTap,
          );
          // return CustomList.listTypeOne(
          //   name: groups[index].grupName ?? ' ',
          //   isRead: isRead,
          //   grupData: groups[index],
          //   onTap: onTap,
          // );*/
        });
  }
}

class ListCardWidget extends StatelessWidget {
  const ListCardWidget({
    Key? key,
    required this.groups,
    required this.index,
    required this.displayName,
    required this.isRead,
  }) : super(key: key);

  final List<Groups> groups;
  final String displayName;
  final int index;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    DateTime time = groups[index].lastMessage!['timeStamp'].toDate();
    DateTime now = DateTime.now();

    DateFormat format = DateFormat('dd-mm-yy   hh:mm a');

    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      format = DateFormat('hh:mm a');
    }

    Color color = Colors.green;

    if (isRead == true && groups[index].lastMessage!['isImportant']) {
      color = Colors.indigo;
    } else if (isRead == true && !groups[index].lastMessage!['isImportant']) {
      color = Colors.amber;
    } else {
      color = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.all(
        12.0,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        elevation: 1,
        color: const Color(0xffE4F0D7),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${groups[index].grupName!.toUpperCase()} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: colorScheme.onSurface,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              groups[index].lastMessage!['type'] == 0
                  ? Text(
                      groups[index].lastMessage!['content'],
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 21,
                        color: isRead ? Colors.black : Colors.grey[800],
                        fontFamily: GoogleFonts.lekton().fontFamily,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Row(
                      children: [
                        Icon(
                          groups[index].lastMessage!['type'] == 2
                              ? Icons.video_camera_back_outlined
                              : Icons.image_outlined,
                          color: isRead ? Colors.black : Colors.grey[600],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          groups[index].lastMessage!['type'] == 2
                              ? 'Video was shared.'
                              : 'Image was shared.',
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 21,
                            color: isRead ? Colors.black : Colors.grey[600],
                            //fontStyle: FontStyle.italic,
                            fontFamily: GoogleFonts.lekton().fontFamily,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'by ${displayName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[600],
                  overflow: TextOverflow.ellipsis,
                  fontFamily: GoogleFonts.lekton().fontFamily,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${format.format(groups[index].lastMessage!['timeStamp'].toDate())} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey[800],
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Divider(
                color: color,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListCardWidgetWeb extends StatelessWidget {
  ListCardWidgetWeb({
    Key? key,
    required this.groups,
    required this.index,
    required this.displayName,
    required this.onTap,
    required this.isRead,
  }) : super(key: key);

  final List<Groups> groups;
  final String displayName;
  final VoidCallback onTap;
  final int index;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    DateTime time = groups[index].lastMessage!['timeStamp'].toDate();
    DateTime now = DateTime.now();

    DateFormat format = DateFormat('dd-mm-yy   hh:mm a');

    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      format = DateFormat('hh:mm a');
    }

    Color color = Colors.green;

    if (isRead == true && groups[index].lastMessage!['isImportant']) {
      color = Colors.indigo;
    } else if (isRead == true && !groups[index].lastMessage!['isImportant']) {
      color = Colors.amber;
    } else {
      color = Colors.green;
    }

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shadowColor: colorScheme.surface.withOpacity(0.2),
        color: const Color(0xffE4F0D7), //colorScheme.surface.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${groups[index].grupName!.toUpperCase()} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: colorScheme.onSurface,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                groups[index].lastMessage!['content'],
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 21,
                  color: isRead ? Colors.black : Colors.grey[800],
                  fontFamily: GoogleFonts.lekton().fontFamily,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'by ${displayName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[600],
                  overflow: TextOverflow.ellipsis,
                  fontFamily: GoogleFonts.lekton().fontFamily,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${format.format(groups[index].lastMessage!['timeStamp'].toDate())} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey[800],
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Divider(
                color: color,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListCardWidget2 extends StatelessWidget {
  ListCardWidget2({
    Key? key,
    required this.groups,
    required this.message,
    required this.displayName,
    required this.isRead,
  }) : super(key: key);

  final Groups groups;
  final String displayName;
  final Messages message;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    DateTime time = message.timeStamp!;
    DateTime now = DateTime.now();

    DateFormat format = DateFormat('dd-mm-yy   hh:mm a');

    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      format = DateFormat('hh:mm a');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 2,
        shadowColor: colorScheme.surface.withOpacity(0.2),
        color: const Color(0xffE4F0D7)
            .withOpacity(0.5), //colorScheme.surface.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${groups.grupName!.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: colorScheme.onSurface,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                message.content!,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 21,
                  color: isRead ? Colors.black : Colors.grey[800],
                  fontFamily: GoogleFonts.lekton().fontFamily,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'by ${displayName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[600],
                  overflow: TextOverflow.ellipsis,
                  fontFamily: GoogleFonts.lekton().fontFamily,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${format.format(message.timeStamp!)} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey[800],
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Divider(
                color: message.isImportant!
                    ? Colors.indigo.withOpacity(0.8)
                    : Colors.green.withOpacity(0.8),
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
