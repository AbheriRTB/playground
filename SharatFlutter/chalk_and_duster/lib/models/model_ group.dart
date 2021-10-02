import 'package:chalk_and_duster/models/model_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Groups {
  final String? grupName;
  final String? grupId;
  final List? grupUsers;
  final String? photoColor;
  final String? lastMessageContent;
  final String? lastMessageFromUid;
  final int? lastMessageType;
  final DateTime? lastMessageTimeStamp;
  final DateTime? timeStamp;

  Groups({
    this.grupName,
    this.grupId,
    this.grupUsers,
    this.photoColor,
    this.lastMessageContent,
    this.lastMessageFromUid,
    this.lastMessageType,
    this.lastMessageTimeStamp,
    this.timeStamp,
  });

  factory Groups.fromDocument(DocumentSnapshot doc) {
    return Groups(
      grupName: doc['grupName'] ?? '',
      grupId: doc['grupId'] ?? '',
      grupUsers: doc['grupUsers'] ?? '',
      photoColor: doc['photoColor'] ?? '',
      lastMessageContent: doc['lastMessageContent'] ?? '',
      lastMessageFromUid: doc['lastMessageFromUid'] ?? '',
      lastMessageType: doc['lastMessageType'] ?? 0,
      lastMessageTimeStamp: doc['lastMessageTimeStamp'].toDate() ?? '',
      timeStamp: doc['timeStamp'].toDate(),
    );
  }

  factory Groups.initialData() {
    return Groups(
      grupName: ' ',
      grupUsers: [],
      photoColor: ' ',
      lastMessageContent: ' ',
      lastMessageFromUid: ' ',
      lastMessageType: 0,
      lastMessageTimeStamp: DateTime.now(),
      timeStamp: DateTime.now(),
    );
  }
}
