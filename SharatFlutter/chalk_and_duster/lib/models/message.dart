import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String? uidFrom;

  final String? message;
  final String? groupId;
  final DateTime? timeStamp;

  Messages({
    this.message,
    this.uidFrom,
    this.groupId,
    this.timeStamp,
  });

  factory Messages.fromDocument(DocumentSnapshot doc) {
    return Messages(
      uidFrom: doc['uidFrom'],
      message: doc['message'],
      groupId: doc['groupId'],
      timeStamp: doc['timeStamp'],
    );
  }
  factory Messages.initialData() {
    return Messages(
      uidFrom: '',
      message: '',
      groupId: '',
      timeStamp: DateTime.now(),
    );
  }
}
