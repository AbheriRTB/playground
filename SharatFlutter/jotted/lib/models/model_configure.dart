import 'package:cloud_firestore/cloud_firestore.dart';

class Configure {
  final bool? userName;
  final bool? authMode;
  final bool? adress;
  final bool? dob;
  final bool? guardianName;
  final bool? userApproval;
  final bool? profilePicture;

  Configure({
    this.userName,
    this.authMode,
    this.adress,
    this.dob,
    this.guardianName,
    this.userApproval,
    this.profilePicture,
  });

  factory Configure.fromDocument(DocumentSnapshot doc) {
    return Configure(
      userName: doc['userName'],
      authMode: doc['authMode'],
      adress: doc['adress'],
      dob: doc['dob'],
      guardianName: doc['guardianName'],
      userApproval: doc['userApproval'],
      profilePicture: doc['profilePicture'],
    );
  }

  factory Configure.initialData() {
    return Configure(
      userName: true,
      authMode: true,
      adress: false,
      dob: true,
      guardianName: true,
      userApproval: true,
      profilePicture: false,
    );
  }
}
