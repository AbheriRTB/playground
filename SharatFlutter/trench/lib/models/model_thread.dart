import 'package:cloud_firestore/cloud_firestore.dart';

class Threads {
  final String? channelId;
  final String? threadName;
  final bool? isArchived;
  final DateTime? timeStamp;

  Threads({
    this.channelId,
    this.threadName,
    this.isArchived,
    this.timeStamp,
  });

  factory Threads.fromDocument(DocumentSnapshot doc) {
    return Threads(
      channelId: doc['channelId'],
      threadName: doc['threadName'],
      isArchived: doc['isArchived'],
      timeStamp: doc['timeStamp'],
    );
  }

  factory Threads.initialData() {
    return Threads(
      channelId: '',
      threadName: '',
      isArchived: false,
      timeStamp: DateTime.now(),
    );
  }
}
