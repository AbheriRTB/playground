import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  final String displayName;
  final String email;
  final String posts;
  final String username;

  Users({
    this.posts,
    this.username,
    this.displayName,
    this.email,
    this.uid,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      uid: doc['id'],
      email: doc['email'],
      username: doc['username'],
      displayName: doc['displayName'],
    );
  }
}
