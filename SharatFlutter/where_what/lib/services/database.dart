import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_what/models/what.dart';

class DatabaseService {
  final String uid;
  String docID;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(String name, String mail) async {
    usersCollection.document(uid).collection("user info").add({
      'name': name,
      'mail': mail,
    });
  }

  Future<void> addWhere(String what, String where, String date) async {
    DocumentReference docRef =
        await usersCollection.document(uid).collection("data").document();
    docRef.setData({
      'what': what,
      'where': where,
      'date': date,
      'docID': docRef.documentID
    });
    return docRef;
  }

  List<What> _whatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return What(
          what: doc.data['what'] ?? '',
          where: doc.data['where'] ?? '',
          date: doc.data['date'] ?? '',
          docID: doc.documentID ?? '');
    }).toList();
  }

  Future<void> updateWhere(
      {String what,
      String where,
      String date,
      String docID,
      String uid}) async {
    DocumentReference docRef =
        await usersCollection.document(uid).collection("data").document(docID);
    docRef.setData({
      'what': what,
      'where': where,
      'date': date,
    });
    return docRef;
  }

  What _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return What(
        what: snapshot.data['what'] ?? '',
        where: snapshot.data['where'] ?? '',
        date: snapshot.data['date'] ?? '',
        docID: snapshot.documentID ?? '');
  }

  Future<void> deleteWhere(String docID, String uid) async {
    return await usersCollection
        .document(uid)
        .collection("data")
        .document(docID)
        .delete();
  }

  // Get Users Stream
  Stream<List<What>> get users {
    final CollectionReference usersNewCollection =
        Firestore.instance.collection('users').document(uid).collection('data');
    return usersNewCollection.snapshots().map(_whatListFromSnapshot);
  }

  Stream<What> get userData {
    final DocumentReference usersNewCollection = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('data')
        .document(docID);
    return usersNewCollection.snapshots().map(_userDataFromSnapshot);
  }
}
