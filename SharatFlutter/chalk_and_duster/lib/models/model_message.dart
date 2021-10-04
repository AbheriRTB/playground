import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String? msgId;
  final String? content;
  final String? uidFrom;
  final String? groupId;
  final List? readUsers;
  final int? type;
  final bool? isImportant;
  final DateTime? timeStamp;

  Messages({
    this.msgId,
    this.content,
    this.uidFrom,
    this.groupId,
    this.readUsers,
    this.type,
    this.isImportant,
    this.timeStamp,
  });

  factory Messages.fromDocument(DocumentSnapshot doc) {
    return Messages(
      msgId: doc['msgId'],
      content: doc['content'],
      uidFrom: doc['uidFrom'],
      groupId: doc['groupId'],
      readUsers: doc['readUsers'],
      type: doc['type'],
      isImportant: doc['isImportant'],
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
      type: 0,
      isImportant: false,
      timeStamp: DateTime.now(),
    );
  }
}
