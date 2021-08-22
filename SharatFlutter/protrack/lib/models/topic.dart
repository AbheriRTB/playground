import 'package:cloud_firestore/cloud_firestore.dart';

class Topic {
  final String topicName;
  final String subjectName;

  Topic({
    this.topicName,
    this.subjectName,
  });

  factory Topic.fromDocument(DocumentSnapshot doc) {
    return Topic(
      topicName: doc['subjectName'],
      subjectName: doc['subject'],
    );
  }
}
