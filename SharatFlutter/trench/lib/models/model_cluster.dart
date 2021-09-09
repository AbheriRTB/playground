import 'package:cloud_firestore/cloud_firestore.dart';

class Cluster {
  final String? clusterId;
  final String? clusterName;
  final String? photoURL;
  final DateTime? timeStamp;

  Cluster({
    this.clusterId,
    this.clusterName,
    this.photoURL,
    this.timeStamp,
  });

  factory Cluster.fromDocument(DocumentSnapshot doc) {
    return Cluster(
      clusterId: doc['clusterId'],
      clusterName: doc['clusterName'],
      photoURL: doc['photoURL'],
      timeStamp: doc['timeStamp'],
    );
  }
  factory Cluster.initialData() {
    return Cluster(
      clusterId: '',
      clusterName: '',
      photoURL: '',
      timeStamp: DateTime.now(),
    );
  }
}
