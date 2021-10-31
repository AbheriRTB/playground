import 'package:cloud_firestore/cloud_firestore.dart';

class Organizations {
  final String? orgId;
  final String? orgName;
  final String? orgContact;
  final String? orgCountry;
  final String? orgCity;
  final String? orgAdress;
  final String? orgBranch;
  final String? orgEmail;
  final Map? configurations;
  final DateTime? timeStamp;

  Organizations({
    this.orgContact,
    this.orgCountry,
    this.orgCity,
    this.orgAdress,
    this.orgBranch,
    this.orgId,
    this.orgName,
    this.orgEmail,
    this.configurations,
    this.timeStamp,
  });

  factory Organizations.fromDocument(DocumentSnapshot doc) {
    return Organizations(
      orgId: doc['orgId'],
      orgName: doc['orgName'],
      orgEmail: doc['orgEmail'],
      orgAdress: doc['orgAdress'] ?? ' ',
      orgBranch: doc['orgBranch'] ?? ' ',
      orgCity: doc['orgCity'],
      orgContact: doc['orgContact'],
      orgCountry: doc['orgCountry'],
      configurations: doc['configure'],
      timeStamp: doc['timeStamp'].toDate(),
    );
  }

  factory Organizations.initialData() {
    return Organizations(
      orgId: ' ',
      orgName: ' ',
      orgEmail: ' ',
      orgAdress: ' ',
      orgBranch: ' ',
      orgCity: ' ',
      orgContact: ' ',
      orgCountry: ' ',
      configurations: {},
      timeStamp: DateTime.now(),
    );
  }
}
