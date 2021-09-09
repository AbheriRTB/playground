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
      uid: doc['uid'],
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
  final String? mobileNo;
  final List<String>? inCluster;
  final String? photoURL;
  final DateTime? timeStamp;

  UsersData({
    this.displayName,
    this.email,
    this.uid,
    this.inCluster,
    this.mobileNo,
    this.photoURL,
    this.timeStamp,
  });

  factory UsersData.fromDocument(DocumentSnapshot doc) {
    return UsersData(
      uid: doc['uid'],
      email: doc['email'],
      displayName: doc['displayName'],
      inCluster: doc['inCluster'],
      mobileNo: doc['mobileNo'],
      photoURL: doc['photoURL'],
      timeStamp: doc['timeStamp'],
    );
  }
  factory UsersData.initialData() {
    return UsersData(
      uid: '',
      email: '',
      displayName: '',
      inCluster: [],
      mobileNo: '',
      photoURL: '',
      timeStamp: DateTime.now(),
    );
  }
}
