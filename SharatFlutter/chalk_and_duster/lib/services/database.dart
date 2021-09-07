import 'package:chalk_and_duster/models/message.dart';
import 'package:chalk_and_duster/models/user.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid, orgId, grupId;
  String? docID, postID;

  DatabaseService({this.uid, this.orgId, this.grupId});
  final DateTime timeStamp = DateTime.now();

  final CollectionReference orgsCollection =
      FirebaseFirestore.instance.collection('orgnizers');
  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
    String displayName,
    String email,
    String orgId,
    String mobileNo,
    bool isAdmin,
    bool isTeacher,
  ) async {
    print('object2');

    await usersCollection.doc(uid).set({
      'id': uid,
      'displayName': displayName,
      'email': email,
      'timsStamp': timeStamp,
      'orgId': orgId,
      'mobileNo': mobileNo,
      'isAdmin': isAdmin,
      'isTeacher': isTeacher,
    });
    print('object3');
  }

  Future<void> createOrg(
    String orgName,
    String orgEmail,
    String orgID,
  ) async {
    final result = await orgsCollection.doc(orgID).set({
      'orgName': orgName,
      'orgEmail': orgEmail,
      'orgID': orgID,
      'timeStamp': timeStamp,
    });
  }

  Future<void> createGrup(
    String grupName,
    List users,
    String orgID,
  ) async {
    final result =
        await orgsCollection.doc(orgID).collection('groups').doc().set({
      'groupName': grupName,
      'users': users,
      'timeStamp': timeStamp,
    });
  }

  Future createMessage(
    String message,
  ) async {
    await orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(grupId)
        .collection('messages')
        .doc(timeStamp.toString())
        .set({
      'message': message,
      'uidFrom': uid,
      'groupId': grupId,
      'timeStamp': timeStamp,
    });
  }

  // User Data from Snapshot
  UsersData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UsersData(
      uid: uid,
      displayName: snapshot['displayName'],
      email: snapshot['email'],
      orgId: snapshot['orgId'],
      mobileNo: snapshot['mobileNo'],
      isAdmin: snapshot['isAdmin'],
      isTeacher: snapshot['isTeacher'],
    );
  } // User Data from Snapshot

  List<Messages> _messagesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Messages(
        uidFrom: doc['uidFrom'] ?? '',
        groupId: doc['groupId'] ?? '',
        message: doc['message'] ?? '',
        timeStamp: timeStamp,
      );
    }).toList();
  }

  // get user data
  Stream<QuerySnapshot> get users {
    return orgsCollection.snapshots();
  }

  // Get User Doc Stream
  Stream<UsersData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get User Doc Stream
  Stream<QuerySnapshot> get grupData {
    return orgsCollection
        .doc(orgId)
        .collection('groups')
        .where('users', arrayContains: uid)
        .snapshots();
  }

  Stream<List<Messages>> get msgs {
    return orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(grupId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(_messagesFromSnapshot);
  }
}
