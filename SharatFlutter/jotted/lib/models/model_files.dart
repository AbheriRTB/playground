import 'package:cloud_firestore/cloud_firestore.dart';

class Files {
  final String? fileName;
  final String? fileUrl;
  final String? uidFrom;
  final String? groupId;
  final DateTime? timeStamp;

  Files({
    this.fileName,
    this.fileUrl,
    this.uidFrom,
    this.groupId,
    this.timeStamp,
  });

  factory Files.fromDocument(DocumentSnapshot doc) {
    return Files(
      fileName: doc['fileName'] ?? '',
      fileUrl: doc['fileUrl'] ?? '',
      uidFrom: doc['uidFrom'] ?? '',
      groupId: doc['groupId'] ?? '',
      timeStamp: doc['timeStamp'].toDate(),
    );
  }

  factory Files.initialData() {
    return Files(
      fileName: ' ',
      fileUrl: ' ',
      uidFrom: ' ',
      groupId: ' ',
      timeStamp: DateTime.now(),
    );
  }
}
