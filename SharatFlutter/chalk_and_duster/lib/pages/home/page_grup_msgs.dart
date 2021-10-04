import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:chalk_and_duster/models/model_message.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/pages/home/classes/dialog_schedule.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:chalk_and_duster/widgets/widget_message.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GroupMessagesPage extends StatefulWidget {
  GroupMessagesPage({
    Key? key,
    required this.grups,
    required this.userData,
  }) : super(key: key);

  UsersData userData;
  Groups grups;

  @override
  _GroupMessagesPageState createState() => _GroupMessagesPageState();
}

class _GroupMessagesPageState extends State<GroupMessagesPage> {
  String? message;

  List? readUsersList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Messages>>(
      stream: DatabaseService(
        grupId: widget.grups.grupId,
        orgId: widget.userData.orgId,
      ).messagesData,
      builder: (context, snapshot) {
        List<Messages> data = snapshot.data!;

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[900]!.withOpacity(0.2),
              elevation: 0,
              bottomOpacity: 0.6,
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xff90D44B),
                  ),
                  insets: EdgeInsets.symmetric(
                    horizontal: 34.0,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Chat',
                      style: TextStyle(
                        color: Color(0xff90D44B).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Files',
                      style: TextStyle(
                        color: Color(0xff90D44B).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Classes',
                      style: TextStyle(
                        color: Color(0xff90D44B).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Tasks',
                      style: TextStyle(
                        color: Color(0xff90D44B).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              title: InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            widget.grups.grupName!,
                            style: TextStyle(
                              fontFamily: 'Integral',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.grups.grupUsers!.length} members',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: TabBarView(
              children: [
                ChatsPageWidget(
                  data: data,
                  grups: widget.grups,
                  userData: widget.userData,
                ),
                Icon(Icons.directions_transit),
                Scaffold(
                  floatingActionButton:
                      widget.userData.isAdmin! || widget.userData.isTeacher!
                          ? FloatingActionButton.extended(
                              label: Text(
                                'Schedule'.toUpperCase(),
                                style: TextStyle(color: Colors.green),
                              ),
                              icon: Icon(
                                Icons.video_call,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScheduleDialog(),
                                      fullscreenDialog: true,
                                    ));
                              },
                              backgroundColor: Colors.white,
                            )
                          : Container(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                ),
                Center(
                  child: Text(
                    'COMMING SOON',
                    style: TextStyle(
                        color: Colors.green[600], fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      initialData: [],
    );
  }
}

class ChatsPageWidget extends StatefulWidget {
  ChatsPageWidget({
    Key? key,
    required this.data,
    required this.grups,
    required this.userData,
  }) : super(key: key);

  List<Messages> data;
  Groups grups;
  UsersData userData;

  @override
  State<ChatsPageWidget> createState() => _ChatsPageWidgetState();
}

class _ChatsPageWidgetState extends State<ChatsPageWidget> {
  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  final ImagePicker _picker = ImagePicker();

  String? message;
  int type = 0;
  bool isImportant = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            reverse: true,
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return MessageWidget(
                msgs: widget.data,
                index: index,
                grups: widget.grups,
                userData: widget.userData,
              );
            },
          ),
        ),
        widget.userData.isAdmin! || widget.userData.isTeacher!
            ? Container(
                //color: secondary,
                child: SafeArea(
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey[900],
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                onChanged: (val) {
                                  setState(() => message = val.trim());
                                },
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey[600]),
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: 'Type your message',
                                  hintStyle: TextStyle(
                                      fontSize: 18.0, color: Colors.grey[600]),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                //keyboardType: TextInputType.phone,
                                autocorrect: true,

                                maxLines: null,
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                String imageUrl = image!.path;
                                if (image.path.isNotEmpty) {
                                  setState(() {
                                    type = 1;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          var alertDialog = AlertDialog(
                                            backgroundColor: Colors.grey[900],
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                imageUrl,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel".toUpperCase(),
                                                  style: TextStyle(
                                                    // fontSize: 13.0,
                                                    color: Color(0xff90D44B)
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await DatabaseService(
                                                      orgId:
                                                          widget.userData.orgId,
                                                      grupId:
                                                          widget.grups.grupId,
                                                      uid: widget.userData.uid,
                                                    ).updateMessageData(
                                                        Messages(
                                                      content: image.path,
                                                      type: 1,
                                                      isImportant: isImportant,
                                                    ));
                                                    await DatabaseService(
                                                      orgId:
                                                          widget.userData.orgId,
                                                      grupId:
                                                          widget.grups.grupId,
                                                      uid: widget.userData.uid,
                                                    ).updateLastMessage(
                                                        Messages(
                                                      content: image.path,
                                                      type: 1,
                                                      isImportant: isImportant,
                                                    ));
                                                  },
                                                  child: Text(
                                                    'SEND',
                                                    style: TextStyle(
                                                      // fontSize: 13.0,
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          );
                                          return alertDialog;
                                        });
                                  });
                                }
                                //print(image);
                              },
                              icon: Icon(
                                Icons.image_outlined,
                                color: Colors.grey[800],
                              )),
                          IconButton(
                              onPressed: () async {
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.camera);
                                String imageUrl = image!.path;
                                if (image.path.isNotEmpty) {
                                  setState(() {
                                    type = 1;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          var alertDialog = AlertDialog(
                                            backgroundColor: Colors.grey[900],
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                imageUrl,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel".toUpperCase(),
                                                  style: TextStyle(
                                                    // fontSize: 13.0,
                                                    color: Color(0xff90D44B)
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await DatabaseService(
                                                      orgId:
                                                          widget.userData.orgId,
                                                      grupId:
                                                          widget.grups.grupId,
                                                      uid: widget.userData.uid,
                                                    ).updateMessageData(
                                                        Messages(
                                                      content: image.path,
                                                      type: 1,
                                                      isImportant: isImportant,
                                                    ));
                                                    await DatabaseService(
                                                      orgId:
                                                          widget.userData.orgId,
                                                      grupId:
                                                          widget.grups.grupId,
                                                      uid: widget.userData.uid,
                                                    ).updateLastMessage(
                                                        Messages(
                                                      content: image.path,
                                                      type: 1,
                                                      isImportant: isImportant,
                                                    ));
                                                  },
                                                  child: Text(
                                                    'SEND',
                                                    style: TextStyle(
                                                      // fontSize: 13.0,
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          );
                                          return alertDialog;
                                        });
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.photo_camera_outlined,
                                color: Colors.grey[800],
                              )),
                          IconButton(
                              onPressed: () async {
                                XFile? image = await _picker.pickVideo(
                                    source: ImageSource.gallery);
                                String imageUrl = image!.path;
                                if (image.path.isNotEmpty) {
                                  setState(() {
                                    type = 1;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          var alertDialog = AlertDialog(
                                            backgroundColor: Colors.grey[900],
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                imageUrl,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel".toUpperCase(),
                                                  style: TextStyle(
                                                    // fontSize: 13.0,
                                                    color: Color(0xff90D44B)
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await DatabaseService(
                                                      orgId:
                                                          widget.userData.orgId,
                                                      grupId:
                                                          widget.grups.grupId,
                                                      uid: widget.userData.uid,
                                                    ).updateMessageData(
                                                        Messages(
                                                      content: image.path,
                                                      type: 1,
                                                      isImportant: isImportant,
                                                    ));
                                                    await DatabaseService(
                                                      orgId:
                                                          widget.userData.orgId,
                                                      grupId:
                                                          widget.grups.grupId,
                                                      uid: widget.userData.uid,
                                                    ).updateLastMessage(
                                                        Messages(
                                                      content: image.path,
                                                      type: 1,
                                                      isImportant: isImportant,
                                                    ));
                                                  },
                                                  child: Text(
                                                    'SEND',
                                                    style: TextStyle(
                                                      // fontSize: 13.0,
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ],
                                          );
                                          return alertDialog;
                                        });
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.movie_creation_outlined,
                                color: Colors.grey[800],
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isImportant = !isImportant;
                                });
                              },
                              icon: Icon(
                                isImportant
                                    ? Icons.label_important
                                    : Icons.label_important_outline,
                                color: isImportant
                                    ? Colors.indigo[500]
                                    : Colors.grey[800],
                              )),
                          Expanded(child: Container()),
                          IconButton(
                              onPressed: () async {
                                controller.clear();
                                await DatabaseService(
                                  orgId: widget.userData.orgId,
                                  grupId: widget.grups.grupId,
                                  uid: widget.userData.uid,
                                ).updateMessageData(Messages(
                                  content: message,
                                  type: type,
                                  isImportant: isImportant,
                                ));
                                await DatabaseService(
                                  orgId: widget.userData.orgId,
                                  grupId: widget.grups.grupId,
                                  uid: widget.userData.uid,
                                ).updateLastMessage(Messages(
                                  content: message,
                                  type: type,
                                  isImportant: isImportant,
                                ));
                                setState(() {
                                  isImportant = false;
                                });
                              },
                              icon: Icon(
                                Icons.send_sharp,
                                color: Colors.grey[700],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
