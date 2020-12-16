import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_what/models/what.dart';

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

  List<What> _whatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return What(
          what: doc.data['what'] ?? '',
          where: doc.data['where'] ?? '',
          date: doc.data['sugars'] ?? '');
    }).toList();
  }

  // Get Users Stream
  Stream<List<What>> get users {
    final CollectionReference usersNewCollection =
        Firestore.instance.collection('users').document(uid).collection('data');
    return usersNewCollection.snapshots().map(_whatListFromSnapshot);
  }
}
