import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:chalk_and_duster/models/model_message.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/services/database.dart';
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
    required this.userData,
  }) : super(key: key);

  List<Messages> msgs;
  int index;
  bool? isMe = false;
  Groups grups;
  UsersData userData;
  bool isOld = true;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users?>(context);

    List readUsersList;
    if (msgs[index].uidFrom == users!.uid) {
      isMe = true;
    }

    readUsers(String msgId) {
      readUsersList = msgs[index].readUsers!;
      for (int i = 0; i < grups.grupUsers!.length; ++i) {
        if (!msgs[index].readUsers!.contains(userData.uid)) {
          readUsersList.add(userData.uid);
          Future.delayed(Duration(seconds: 3)).then((_) {
            DatabaseService(
              orgId: userData.orgId,
              grupId: grups.grupId,
            ).readMessage(readUsersList, msgId);
          });
        }
      }
      // if (isOld) {
      //   if (msgs[index].timeStamp!.difference(msgs[index - 1].timeStamp!) >
      //       Duration(minutes: 1)) {
      //     isOld = true;
      //   }
      // }
    }

    bool hasRead = !msgs[index].readUsers!.contains(userData.uid);

    return StreamBuilder<UsersData>(
        stream: DatabaseService(uid: msgs[index].uidFrom).userData,
        initialData: UsersData.initialData(),
        builder: (context, snapshot) {
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
          UsersData data = snapshot.data!;
          readUsers(msgs[index].msgId!);
          return isOld
              ? NewMessage(
                  msgs: msgs, index: index, hasRead: hasRead, data: data)
              : NewMessageOld(
                  msgs: msgs, index: index, hasRead: hasRead, data: data);
        });
  }
}

class NewMessage extends StatelessWidget {
  NewMessage({
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

  final format = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                maxRadius: 14.0,
                foregroundImage: data.photoUrl!.isNotEmpty
                    ? NetworkImage(data.photoUrl!)
                    : NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png'),
                backgroundColor: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('${data.displayName![0]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Integral',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      )),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          data.displayName!,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Integral',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          format.format(msgs[index].timeStamp!),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Integral',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      AnimatedOpacity(
                        opacity: !hasRead ? 0 : 1,
                        duration: Duration(seconds: 1),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            'New',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Integral',
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[700],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Linkable(
                      text: msgs[index].content!,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      textColor: Colors.grey[400],
                      linkColor: Colors.indigo[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0,
                child: CircleAvatar(
                  maxRadius: 14.0,
                  foregroundImage: data.photoUrl!.isNotEmpty
                      ? NetworkImage(data.photoUrl!)
                      : NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png'),
                  backgroundColor: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text('${data.displayName![0]}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Integral',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Linkable(
                      text: msgs[index].content!,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      textColor: Colors.grey[400],
                      linkColor: Colors.indigo[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
