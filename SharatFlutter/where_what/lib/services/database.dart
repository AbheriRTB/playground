import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(String name, String mail) async {
    return await usersCollection.document(uid).collection("user info").add({
      'name': name,
      'mail': mail,
    });
  }

  Future<void> addWhere(String what, String where, String date) async {
    return await usersCollection.document(uid).collection("data").add({
      'what': what,
      'where': where,
      'date': date,
    });
  }

  // Get Users Stream
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}
