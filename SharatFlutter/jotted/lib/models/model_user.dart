import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? uid;
  final String? email;

  Users({
    this.email,
    this.uid,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      uid: doc['id'],
      email: doc['email'],
    );
  }
  factory Users.initialData() {
    return Users(
      uid: ' ',
      email: ' ',
    );
  }
}

// User Data Model
class UsersData {
  final String? uid;
  final String? displayName;
  final String? email;
  final String? mobileNo;
  final String? orgId;
  final bool? isAdmin;
  final bool? isTeacher;
  final String? photoUrl;
  final String? adress;
  final DateTime? dob;
  final String? guardianName;
  final bool? approved;

  UsersData({
    this.uid,
    this.displayName,
    this.email,
    this.mobileNo,
    this.orgId,
    this.isAdmin,
    this.isTeacher,
    this.photoUrl,
    this.adress,
    this.dob,
    this.guardianName,
    this.approved,
  });

  factory UsersData.fromDocument(DocumentSnapshot doc) {
    return UsersData(
      uid: doc['uid'],
      displayName: doc['displayName'],
      email: doc['email'],
      mobileNo: doc['mobileNo'],
      orgId: doc['orgId'],
      isAdmin: doc['isAdmin'],
      isTeacher: doc['isTeacher'],
      photoUrl: doc['photoUrl'],
      adress: doc['adress'],
      dob: doc['dob'].toDate(),
      guardianName: doc['guardianName'],
      approved: doc['approved'],
    );
  }
  factory UsersData.initialData() {
    return UsersData(
      uid: ' ',
      displayName: ' ',
      email: ' ',
      mobileNo: ' ',
      orgId: ' ',
      isAdmin: false,
      isTeacher: false,
      photoUrl: ' ',
      adress: ' ',
      dob: DateTime.now(),
      guardianName: ' ',
      approved: false,
    );
  }
}
