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
      uid: '',
      email: '',
    );
  }
}

class UsersData {
  final String? uid;
  final String? displayName;
  final String? email;
  final String? orgId;
  final String? mobileNo;
  final bool? isAdmin;
  final bool? isTeacher;

  UsersData({
    this.displayName,
    this.email,
    this.uid,
    this.orgId,
    this.mobileNo,
    this.isAdmin,
    this.isTeacher,
  });

  factory UsersData.fromDocument(DocumentSnapshot doc) {
    return UsersData(
      uid: doc['id'],
      email: doc['email'],
      displayName: doc['displayName'],
      orgId: doc['orgId'],
      mobileNo: doc['mobileNo'],
      isAdmin: doc['isAdmin'],
      isTeacher: doc['isTeacher'],
    );
  }
  factory UsersData.initialData() {
    return UsersData(
      uid: '',
      email: '',
      displayName: '',
      orgId: '',
      mobileNo: '',
      isAdmin: false,
      isTeacher: false,
    );
  }
}
