import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('data');

  Future<void> updateUserData(String name, String mail) async {
    return await usersCollection.document(uid).collection("trips").add({
      'name': name,
      'mail': mail,
    });
  }

  // Get Users Stream
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }
}