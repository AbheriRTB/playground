import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:chalk_and_duster/models/model_message.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/services/database.dart';
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
          readUsers(msgs[index].msgId!);
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
                      foregroundImage: snapshot.data!.photoUrl!.isNotEmpty
                          ? NetworkImage(snapshot.data!.photoUrl!)
                          : NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png'),
                      backgroundColor: Colors.grey[100],
                      child: Text('${snapshot.data!.displayName![0]}',
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey[600])),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              snapshot.data!.displayName!,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.grey[600]),
                            ),
                            SizedBox(
                              width: 18.0,
                            ),
                            Text(
                              msgs[index].timeStamp!.hour.toString() +
                                  ':' +
                                  msgs[index].timeStamp!.minute.toString(),
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.grey[600]),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            hasRead
                                ? CircleAvatar(
                                    maxRadius: 4,
                                    backgroundColor: Colors.green,
                                  )
                                : Container(),
                            SizedBox(
                              width: 4.0,
                            ),
                            hasRead
                                ? Text(
                                    'New',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[600]),
                                  )
                                : Container(),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            msgs[index].content!,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
