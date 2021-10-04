import 'package:chalk_and_duster/models/model_%20group.dart';
import 'package:chalk_and_duster/models/model_%20organization.dart';
import 'package:chalk_and_duster/models/model_message.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid, orgId, grupId;

  DatabaseService({this.uid, this.orgId, this.grupId});
  final DateTime timeStamp = DateTime.now();

  // Orgs Reference
  final CollectionReference orgsCollection =
      FirebaseFirestore.instance.collection('orgnizers');

  // Users Reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
    UsersData usersData,
  ) async {
    print('creating ${usersData.uid}');
    final result = await usersCollection.doc(usersData.uid).set({
      'uid': usersData.uid,
      'displayName': usersData.displayName,
      'email': usersData.email,
      'photoUrl': usersData.photoUrl,
      'orgId': usersData.orgId,
      'mobileNo': usersData.mobileNo,
      'isAdmin': usersData.isAdmin,
      'isTeacher': usersData.isTeacher,
      'timsStamp': timeStamp,
    }).onError((error, stackTrace) => print);
  }

  Future<void> updateOrganizationData(
    Organizations organization,
  ) async {
    await orgsCollection.doc(organization.orgId).set({
      'orgId': organization.orgId,
      'orgName': organization.orgName,
      'orgEmail': organization.orgEmail,
      'timeStamp': timeStamp,
    });
  }

  Future<void> updateGroupData(
    Groups group,
  ) async {
    var randomDoc = orgsCollection.doc(orgId).collection('groups').doc().id;

    await orgsCollection.doc(orgId).collection('groups').doc(randomDoc).set({
      'grupName': group.grupName,
      'grupId': randomDoc,
      'grupUsers': group.grupUsers,
      'photoColor': group.photoColor,
      'lastMessage': {
        'content': 'No Messages Yet',
        'uidFrom': ' ',
        'type': 0,
        'isImportant': false,
        'timeStamp': timeStamp,
      },
      'timeStamp': timeStamp,
    });
  }

  Future<void> updateLastMessage(
    Messages messages,
  ) async {
    await orgsCollection.doc(orgId).collection('groups').doc(grupId).update({
      'lastMessage': {
        'content': messages.content,
        'uidFrom': uid,
        'type': messages.type,
        'isImportant': messages.isImportant,
        'timeStamp': timeStamp,
      }
    });
  }

  Future updateMessageData(
    Messages message,
  ) async {
    var randomDoc = orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(timeStamp.toString())
        .id;

    await orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(grupId)
        .collection('messages')
        .doc(randomDoc)
        .set({
      'msgId': randomDoc,
      'content': message.content,
      'uidFrom': uid,
      'groupId': grupId,
      'readUsers': [uid],
      'type': message.type,
      'isImportant': message.isImportant,
      'timeStamp': timeStamp,
    });
  }

  Future readMessage(
    List readUser,
    String msgId,
  ) async {
    await orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(grupId)
        .collection('messages')
        .doc(msgId)
        .update({
      'readUsers': readUser,
    });
  }

  // get user data
  Stream<QuerySnapshot> get users {
    return orgsCollection.snapshots();
  }

  // Get User Doc Stream
  Stream<UsersData> get userData {
    return usersCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot)
        .handleError((onError) {
      print(onError);
    });
  }

  // Get Organizations Doc Stream
  Stream<Organizations> get orgsData {
    return orgsCollection.doc(orgId).snapshots().map(_orgsDataFromSnapshot);
  }

  // Get Group Doc Stream
  Stream<Groups> get groupData {
    return orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(grupId)
        .snapshots()
        .map(_groupDataFromSnapshot);
  }

  // Get Groups List Doc Stream
  Stream<List<Groups>> get groupsList {
    return orgsCollection
        .doc(orgId!)
        .collection('groups')
        .where('grupUsers', arrayContains: uid!)
        .snapshots()
        .map(_groupsListFromSnapshot)
        .handleError((onError) {
      print(onError);
    });
  }

  // Get Messages Doc Stream
  Stream<List<Messages>> get messagesData {
    return orgsCollection
        .doc(orgId)
        .collection('groups')
        .doc(grupId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(_messagesFromSnapshot)
        .handleError((onError) {
      print(onError);
    });
  }

  // User Data from Snapshot
  UsersData _userDataFromSnapshot(DocumentSnapshot doc) {
    return UsersData.fromDocument(doc);
  }

  // Organizations Data from Snapshot
  Organizations _orgsDataFromSnapshot(DocumentSnapshot snapshot) {
    return Organizations.fromDocument(snapshot);
  }

  // Groups Data from Snapshot
  Groups _groupDataFromSnapshot(DocumentSnapshot snapshot) {
    return Groups.fromDocument(snapshot);
  }

  // List Groups Data from Snapshot
  List<Groups> _groupsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Groups.fromDocument(doc);
    }).toList();
  }

  // Messages Data from Snapshot
  List<Messages> _messagesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Messages.fromDocument(doc);
    }).toList();
  }
}
