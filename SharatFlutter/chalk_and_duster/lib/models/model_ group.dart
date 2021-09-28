import 'package:cloud_firestore/cloud_firestore.dart';

class Groups {
  final String? grupName;
  final String? grupId;
  final List? grupUsers;
  final String? photoColor;
  final DateTime? timeStamp;

  Groups({
    this.grupName,
    this.grupId,
    this.grupUsers,
    this.photoColor,
    this.timeStamp,
  });

  factory Groups.fromDocument(DocumentSnapshot doc) {
    return Groups(
      grupName: doc['grupName'],
      grupId: doc['grupId'],
      grupUsers: doc['grupUsers'],
      photoColor: doc['photoColor'],
      timeStamp: doc['timeStamp'].toDate(),
    );
  }

  factory Groups.initialData() {
    return Groups(
      grupName: '',
      grupUsers: [],
      photoColor: '',
      timeStamp: DateTime.now(),
    );
  }
}
