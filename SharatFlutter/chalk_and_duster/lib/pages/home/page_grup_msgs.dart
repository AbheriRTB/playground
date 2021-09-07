import 'package:chalk_and_duster/models/message.dart';
import 'package:chalk_and_duster/models/user.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupMessagesPage extends StatefulWidget {
  GroupMessagesPage(
      {Key? key,
      required this.grupId,
      required this.orgId,
      required this.userData})
      : super(key: key);

  String grupId;
  String orgId;
  UsersData userData;

  @override
  _GroupMessagesPageState createState() => _GroupMessagesPageState();
}

class _GroupMessagesPageState extends State<GroupMessagesPage> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  String? message;

  Color primary = Color(0xff303242);

  Color secondary = Color(0xff394359);

  Color accentDark = Color(0xffE0C097);

  Color accent = Color(0xffB85C38);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Messages>>(
        stream: DatabaseService(
          grupId: widget.grupId,
          orgId: widget.orgId,
        ).msgs,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Users user = Provider.of<Users>(context);
          // if (!snapshot.hasData) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return Scaffold(
            backgroundColor: primary,
            appBar: AppBar(
              //backgroundColor: secondary,
              title: Text('Bye'),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: accent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return MessageWidget(
                        msgs: data,
                        index: index,
                      );
                    },
                  ),
                ),
                widget.userData.isAdmin! || widget.userData.isTeacher!
                    ? Container(
                        color: secondary,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    onChanged: (val) {
                                      setState(() => message = val.trim());
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: primary,
                                      hintText: ' Type your message',
                                      hintStyle: TextStyle(
                                          color: accentDark.withOpacity(0.5)),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0),
                                        gapPadding: 10,
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    maxLines: null,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                CircleAvatar(
                                  backgroundColor: primary,
                                  minRadius: 12,
                                  child: IconButton(
                                    onPressed: () {
                                      message!.trim() != ''
                                          ? createMessage(
                                              widget.orgId,
                                              user.uid!,
                                              widget.grupId,
                                              message!)
                                          : print('null');
                                      controller.clear();
                                    },
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: accent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  createMessage(
    String orgID,
    String uid,
    String grupId,
    String message,
  ) {
    DatabaseService(
      grupId: grupId,
      orgId: orgID,
      uid: uid,
    ).createMessage(message);
  }
}

class MessageWidget extends StatelessWidget {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  MessageWidget({
    Key? key,
    required this.msgs,
    required this.index,
  }) : super(key: key);

  final List<Messages> msgs;
  final int index;
  bool? isMe = false;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);
    if (msgs[index].uidFrom == users!.uid) {
      isMe = true;
    }
    return StreamBuilder<UsersData>(
        stream: DatabaseService(uid: msgs[index].uidFrom).userData,
        builder: (context, snapshot) {
          return Align(
            alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(isMe! ? 120 : 8, 8, isMe! ? 8 : 120, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                    color: isMe! ? accent : secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.displayName!,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            msgs[index].message!,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        });
  }
}
