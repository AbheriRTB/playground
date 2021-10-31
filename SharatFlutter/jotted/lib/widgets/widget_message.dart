import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jotted/models/model_group.dart';
import 'package:jotted/models/model_message.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/database.dart';
import 'package:intl/intl.dart';
import 'package:linkable/linkable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({
    Key? key,
    required this.msgs,
    required this.index,
    required this.grups,
    required this.web,
    required this.userData,
  }) : super(key: key);

  List<Messages> msgs;
  int index;
  bool? isMe = false;
  Groups grups;
  UsersData userData;
  bool isOld = true;
  bool web = false;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    List readUsersList;
    if (msgs[index].uidFrom == users!.uid) {
      isMe = true;
    }

    readUsers(String msgId) {
      readUsersList = msgs[index].readUsers!;
      for (int i = 0; i < grups.grupUsers!.length; ++i) {
        if (!msgs[index].readUsers!.contains(userData.uid)) {
          readUsersList.add(userData.uid);
          Future.delayed(const Duration(seconds: 3)).then((_) {
            DatabaseService(
              orgId: userData.orgId,
              grupId: grups.grupId,
            ).readMessage(readUsersList, msgId);
          });
        }
      }
      if (index > 1) {
        if (msgs[index].timeStamp!.minute ==
            msgs[index - 1].timeStamp!.minute) {
          isOld = true;
        }
      }
    }

    bool hasRead = !msgs[index].readUsers!.contains(userData.uid);

    return StreamBuilder<UsersData>(
        stream: DatabaseService(uid: msgs[index].uidFrom).userData,
        initialData: UsersData.initialData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          UsersData data = snapshot.data!;
          readUsers(msgs[index].msgId!);
          return userData.isAdmin! ||
                  userData.isTeacher! && msgs[index].uidFrom == userData.uid
              ? Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actions: [
                    IconSlideAction(
                      caption: 'Delete',
                      color: colorScheme.secondaryVariant,
                      icon: Icons.delete,
                      onTap: () {},
                    ),
                  ],
                  child: NewMessage(
                      web: web,
                      msgs: msgs,
                      index: index,
                      hasRead: hasRead,
                      data: data),
                )
              : NewMessage(
                  web: web,
                  msgs: msgs,
                  index: index,
                  hasRead: hasRead,
                  data: data);
        });
  }
}

class NewMessage extends StatelessWidget {
  NewMessage({
    Key? key,
    required this.msgs,
    required this.index,
    required this.hasRead,
    required this.web,
    required this.data,
  }) : super(key: key);

  final List<Messages> msgs;
  final int index;
  final bool hasRead;
  bool web = false;
  final UsersData data;

  final format = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 14.0,
              /*   foregroundImage: data.photoUrl!.isNotEmpty
                  ? NetworkImage(data.photoUrl!)
                  : NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png'),*/
              backgroundColor: colorScheme.secondaryVariant,
              child: Text(data.displayName![0],
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSecondary,
                  )),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        data.displayName!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.0,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        format.format(msgs[index].timeStamp!),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey[600],
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Visibility(
                      visible: msgs[index].isImportant!,
                      child: AnimatedOpacity(
                        opacity: !msgs[index].isImportant! ? 0 : 1,
                        duration: Duration(seconds: 1),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ScaleAnimatedText(
                                'IMPORTANT',
                                scalingFactor: 1,
                                duration: Duration(seconds: 5),
                                textStyle: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Integral',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900],
                                ),
                              ),
                              ScaleAnimatedText(
                                'IMPORTANT',
                                scalingFactor: 1,
                                duration: Duration(seconds: 5),
                                textStyle: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: msgs[index].isImportant!,
                        child: const SizedBox(
                          width: 8.0,
                        )),
                    AnimatedOpacity(
                      opacity: !hasRead ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          'New',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                msgs[index].type == 0
                    ? SizedBox(
                        width: !web
                            ? MediaQuery.of(context).size.width - 100
                            : MediaQuery.of(context).size.width / 3,
                        child: Linkable(
                          text: msgs[index].content!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 21,
                            fontFamily: GoogleFonts.lekton().fontFamily,
                          ),
                          linkColor: colorScheme.primaryVariant,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              msgs[index].content!,
                              scale: 2,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewMessageOld extends StatelessWidget {
  NewMessageOld({
    Key? key,
    required this.msgs,
    required this.index,
    required this.hasRead,
    required this.data,
  }) : super(key: key);

  final List<Messages> msgs;
  final int index;
  final bool hasRead;
  final UsersData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0,
              child: CircleAvatar(
                maxRadius: 14.0,
                /* foregroundImage: data.photoUrl != null
                    ? NetworkImage(data.photoUrl!)
                    : NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png'),*/
                backgroundColor: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('${data.displayName![0]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      )),
                ),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Linkable(
                  text: msgs[index].content!,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                  linkColor: Colors.indigo[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
