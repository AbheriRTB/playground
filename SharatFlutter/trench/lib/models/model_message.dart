import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String? threadId;
  final String? content;

  final String? sentUid;
  final DateTime? timeStamp;

  Messages({
    this.threadId,
    this.content,
    this.sentUid,
    this.timeStamp,
  });

  factory Messages.fromDocument(DocumentSnapshot doc) {
    return Messages(
      threadId: doc['threadId'],
      content: doc['content'],
      sentUid: doc['sentUid'],
      timeStamp: doc['timeStamp'],
    );
  }
  factory Messages.initialData() {
    return Messages(
      threadId: '',
      content: '',
      sentUid: '',
      timeStamp: DateTime.now(),
    );
  }
}
