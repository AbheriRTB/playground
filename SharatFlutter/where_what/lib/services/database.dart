import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_what/models/what.dart';

class DatabaseService {
  final String uid;
  String docID;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String name, String mail) async {
    usersCollection.doc(uid).collection("user info").add({
      'name': name,
      'mail': mail,
    });
  }

  Future<void> addWhere(String what, String where, String date) async {
    DocumentReference docRef =
        await usersCollection.doc(uid).collection("data").doc();
    docRef
        .set({'what': what, 'where': where, 'date': date, 'docID': docRef.id});
    return docRef;
  }

  List<What> _whatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return What(
          what: doc['what'] ?? '',
          where: doc['where'] ?? '',
          date: doc['date'] ?? '',
          docID: doc.id ?? '');
    }).toList();
  }

  Future<void> updateWhere(
      {String what,
      String where,
      String date,
      String docID,
      String uid}) async {
    DocumentReference docRef =
        await usersCollection.doc(uid).collection("data").doc(docID);
    docRef.set({
      'what': what,
      'where': where,
      'date': date,
    });
    return docRef;
  }

  What _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return What(
        what: snapshot['what'] ?? '',
        where: snapshot['where'] ?? '',
        date: snapshot['date'] ?? '',
        docID: snapshot.id ?? '');
  }

  Future<void> deleteWhere(String docID, String uid) async {
    return await usersCollection
        .doc(uid)
        .collection("data")
        .doc(docID)
        .delete();
  }

  // Get Users Stream
  Stream<List<What>> get users {
    final CollectionReference usersNewCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('data');
    return usersNewCollection.snapshots().map(_whatListFromSnapshot);
  }

  Stream<What> get userData {
    final DocumentReference usersNewCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('data')
        .doc(docID);
    return usersNewCollection.snapshots().map(_userDataFromSnapshot);
  }
}
