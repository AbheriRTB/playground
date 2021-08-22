import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  String docID, postID;

  DatabaseService({this.uid});
  final DateTime timeStamp = DateTime.now();

  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
    String displayName,
    String email,
  ) async {
    usersCollection.doc(uid).set({
      'id': uid,
      'displayName': displayName,
      'email': email,
      'posts': 0,
      'timsStamp': timeStamp,
    });
  }

  Future<void> createGoal(String goalName, String discription, int endDate,
      String durationUnit) async {
    usersCollection.doc(uid).collection('goal').doc().set({
      'goalName': goalName,
      'discription': discription,
      'endDate': endDate,
    });
  }

  Future<void> createSubject(
    String subjectName,
    String discription,
  ) async {
    await usersCollection.doc(uid).collection('subjects').add({
      'subjectName': subjectName,
      'discription': discription,
    });
  }

  Future<void> createTopic(
    String topicName,
    String discription,
    String subject,
    String subID,
  ) async {
    await usersCollection
        .doc(uid)
        .collection('subjects')
        .doc(subID)
        .collection('topics')
        .add({
      'subjectName': topicName,
      'discription': discription,
      'subject': subject,
    });
  }
}
