import 'package:cloud_firestore/cloud_firestore.dart';

class Channels {
  final String? clusterId;
  final String? channelName;
  final List<String>? channelMembers;
  final String? photoURL;
  final DateTime? timeStamp;

  Channels({
    this.clusterId,
    this.channelName,
    this.channelMembers,
    this.photoURL,
    this.timeStamp,
  });

  factory Channels.fromDocument(DocumentSnapshot doc) {
    return Channels(
      clusterId: doc['clusterId'],
      channelName: doc['channelName'],
      channelMembers: doc['channelMembers'],
      photoURL: doc['photoURL'],
      timeStamp: doc['timeStamp'],
    );
  }
  factory Channels.initialData() {
    return Channels(
      clusterId: '',
      channelName: '',
      channelMembers: [],
      photoURL: '',
      timeStamp: DateTime.now(),
    );
  }
}
