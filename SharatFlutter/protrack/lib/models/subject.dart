import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  final String subID;
  final String subjectName;

  Subject({
    this.subID,
    this.subjectName,
  });

  factory Subject.fromDocument(DocumentSnapshot doc) {
    return Subject(
      subID: doc.id,
      subjectName: doc['subjectName'],
    );
  }
}
