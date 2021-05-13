import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  String docID, postID;

  DatabaseService({this.uid});
  final DateTime timeStamp = DateTime.now();

  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> updateUserData(
    String displayName,
    String email,
  ) async {
    usersCollection.doc(uid).set({
      'id': uid,
      'displayName': displayName,
      'email': email,
      'username': '',
      'bio': '',
      'posts': 0,
      'timsStamp': timeStamp,
    });
  }

  Future<void> createPost(String dishName, String recipie, int durationTime,
      String durationUnit) async {
    postCollection.doc(uid).collection('userPosts').doc().set({
      'userId': uid,
      'dishName': dishName,
      'recipie': recipie,
      'duration.time': durationTime,
      'duration.unit': durationUnit,
      'postID': '',
      'likes': [],
      'timsStamp': timeStamp,
    });
  }
}
