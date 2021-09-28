import 'package:cloud_firestore/cloud_firestore.dart';

class Organizations {
  final String? orgId;
  final String? orgName;
  final String? orgEmail;
  final DateTime? timeStamp;

  Organizations({
    this.orgId,
    this.orgName,
    this.orgEmail,
    this.timeStamp,
  });

  factory Organizations.fromDocument(DocumentSnapshot doc) {
    return Organizations(
      orgId: doc['orgId'],
      orgName: doc['orgName'],
      orgEmail: doc['orgEmail'],
      timeStamp: doc['timeStamp'],
    );
  }

  factory Organizations.initialData() {
    return Organizations(
      orgId: '',
      orgName: '',
      orgEmail: '',
      timeStamp: DateTime.now(),
    );
  }
}
