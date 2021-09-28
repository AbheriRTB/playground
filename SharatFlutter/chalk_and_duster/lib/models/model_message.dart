import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String? msgId;
  final String? content;
  final String? uidFrom;
  final String? groupId;
  final List? readUsers;
  final DateTime? timeStamp;

  Messages({
    this.msgId,
    this.content,
    this.uidFrom,
    this.groupId,
    this.readUsers,
    this.timeStamp,
  });

  factory Messages.fromDocument(DocumentSnapshot doc) {
    return Messages(
      msgId: doc['msgId'],
      content: doc['content'],
      uidFrom: doc['uidFrom'],
      groupId: doc['groupId'],
      readUsers: doc['readUsers'],
      timeStamp: doc['timeStamp'].toDate(),
    );
  }

  factory Messages.initialData() {
    return Messages(
      msgId: '',
      content: '',
      uidFrom: '',
      groupId: '',
      readUsers: [],
      timeStamp: DateTime.now(),
    );
  }
}
