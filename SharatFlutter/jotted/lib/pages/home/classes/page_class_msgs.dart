import 'package:google_fonts/google_fonts.dart';
import 'package:jotted/models/model_group.dart';
import 'package:jotted/models/model_message.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/pages/home/classes/page_class_details.dart';
import 'package:jotted/services/database.dart';
import 'package:jotted/widgets/widget_message.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GroupMessagesPage extends StatefulWidget {
  GroupMessagesPage({
    Key? key,
    required this.grups,
    required this.web,
  }) : super(key: key);

  Groups grups;
  bool web;

  @override
  _GroupMessagesPageState createState() => _GroupMessagesPageState();
}

class _GroupMessagesPageState extends State<GroupMessagesPage> {
  String? message;

  List? readUsersList;

  @override
  Widget build(BuildContext context) {
    UsersData userData = Provider.of<UsersData>(context);

    return StreamBuilder<List<Messages>>(
      stream: DatabaseService(
        grupId: widget.grups.grupId,
        orgId: userData.orgId,
      ).messagesData,
      builder: (context, snapshot) {
        List<Messages> data = snapshot.data!;

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottomOpacity: 0.8,
              backgroundColor: widget.web
                  ? Theme.of(context).colorScheme.primaryVariant
                  : Theme.of(context).appBarTheme.backgroundColor,
              bottom: TabBar(
                indicator: const UnderlineTabIndicator(
                  insets: EdgeInsets.symmetric(
                    horizontal: 36.0,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Chat'.toUpperCase(),
                    ),
                  ),
                  /* Tab(
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
                  ),*/
                  Tab(
                    child: Text(
                      'Tasks'.toUpperCase(),
                    ),
                  ),
                ],
              ),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassDetailsPage(
                          group: widget.grups,
                        ),
                      ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            widget.grups.grupName!.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.arrow_right,
                        ),
                      ],
                    ),
                    Text(
                      '${widget.grups.grupUsers!.length} members',
                      style: const TextStyle(
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
                  widget.web ? Icons.group : Icons.arrow_back,
                ),
                disabledColor: Theme.of(context).colorScheme.background,
                onPressed: widget.web
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
              ),
            ),
            body: TabBarView(
              children: [
                ChatsPageWidget(
                  web: widget.web,
                  data: data,
                  grups: widget.grups,
                  userData: userData,
                ),
                /*Icon(Icons.directions_transit),
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
                ),*/
                const Center(
                  child: Text(
                    'COMMING SOON',
                    style: TextStyle(
                        fontFamily: 'Integral', fontStyle: FontStyle.italic),
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
    required this.web,
    required this.userData,
  }) : super(key: key);

  List<Messages> data;
  Groups grups;
  bool web = false;
  UsersData userData;

  @override
  State<ChatsPageWidget> createState() => _ChatsPageWidgetState();
}

class _ChatsPageWidgetState extends State<ChatsPageWidget> {
  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();
  final _key = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();

  String? message;
  int type = 0;
  bool isImportant = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              reverse: true,
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                  msgs: widget.data,
                  web: widget.web,
                  index: index,
                  grups: widget.grups,
                  userData: widget.userData,
                );
              },
            ),
          ),
          widget.userData.isAdmin! || widget.userData.isTeacher!
              ? SafeArea(
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) => value!.isNotEmpty
                                    ? null
                                    : 'Enter School Email',
                                controller: controller,
                                onChanged: (val) {
                                  setState(() => message = val.trim());
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                                focusNode: _focusNode,
                                decoration: const InputDecoration(
                                  filled: false,
                                  hintText: 'Type your message',
                                  hintStyle: TextStyle(
                                    fontSize: 18.0,
                                  ),
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
                            const SizedBox(
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
                                                    grupId: widget.grups.grupId,
                                                    uid: widget.userData.uid,
                                                  ).updateMessageData(Messages(
                                                    content: image.path,
                                                    type: 1,
                                                    isImportant: isImportant,
                                                  ));
                                                  await DatabaseService(
                                                    orgId:
                                                        widget.userData.orgId,
                                                    grupId: widget.grups.grupId,
                                                    uid: widget.userData.uid,
                                                  ).updateLastMessage(Messages(
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
                                                    fontWeight: FontWeight.bold,
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
                            icon: const Icon(
                              Icons.image_outlined,
                            ),
                          ),
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
                                                    grupId: widget.grups.grupId,
                                                    uid: widget.userData.uid,
                                                  ).updateMessageData(Messages(
                                                    content: image.path,
                                                    type: 1,
                                                    isImportant: isImportant,
                                                  ));
                                                  await DatabaseService(
                                                    orgId:
                                                        widget.userData.orgId,
                                                    grupId: widget.grups.grupId,
                                                    uid: widget.userData.uid,
                                                  ).updateLastMessage(Messages(
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ],
                                        );
                                        return alertDialog;
                                      });
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.photo_camera_outlined,
                            ),
                          ),
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
                                                    grupId: widget.grups.grupId,
                                                    uid: widget.userData.uid,
                                                  ).updateMessageData(Messages(
                                                    content: image.path,
                                                    type: 1,
                                                    isImportant: isImportant,
                                                  ));
                                                  await DatabaseService(
                                                    orgId:
                                                        widget.userData.orgId,
                                                    grupId: widget.grups.grupId,
                                                    uid: widget.userData.uid,
                                                  ).updateLastMessage(Messages(
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ],
                                        );
                                        return alertDialog;
                                      });
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.movie_creation_outlined,
                            ),
                          ),
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
                            ),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
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

                                _focusNode.unfocus();
                              }
                            },
                            icon: const Icon(
                              Icons.send_sharp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
