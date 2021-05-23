import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String userId;
  final String dishName;
  final String recipie;
  final int durationTime;
  final String durationUnit;
  final String postID;
  final Map likes;
  final DateTime timsStamp;

  Posts({
    this.userId,
    this.dishName,
    this.recipie,
    this.durationTime,
    this.durationUnit,
    this.postID,
    this.likes,
    this.timsStamp,
  });

  factory Posts.fromDocument(DocumentSnapshot doc) {
    return Posts(
      userId: doc.data()['userId'],
      dishName: doc.data()['dishName'],
      recipie: doc.data()['recipie'],
      durationTime: doc.data()['duration.time'],
      durationUnit: doc.data()['duration.unit'],
      postID: doc.data()['postID'],
      //likes: doc.data()['likes'],
      timsStamp: doc.data()['timeStamp'],
    );
  }
}
