import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trench/models/model_channel.dart';
import 'package:trench/models/model_cluster.dart';
import 'package:trench/models/model_message.dart';
import 'package:trench/models/model_thread.dart';
import 'package:trench/models/model_user.dart';

class DatabaseService {
  final String? uid;
  final String? clusterId;
  final String? channelId;
  final String? threadId;

  DatabaseService({
    this.uid,
    this.clusterId,
    this.channelId,
    this.threadId,
  });

  // Timestamp
  final DateTime timeStamp = DateTime.now();

  // User collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Cluster collection refrence
  final CollectionReference clusterCollection =
      FirebaseFirestore.instance.collection('clusters');

  // Create and update user data
  Future<void> updateUserData(
    UsersData userData,
  ) async {
    await usersCollection.doc(uid).set({
      'id': uid,
      'displayName': userData.displayName,
      'email': userData.email,
      'inCluster': userData.inCluster,
      'mobileNo': userData.mobileNo,
      'photoURL': userData.photoURL,
      'timsStamp': timeStamp,
    });
  }

  // Create and update cluster data
  Future<void> updateClusterData(
    Cluster cluster,
  ) async {
    await clusterCollection.doc(cluster.clusterId).set({
      'clusterId': cluster.clusterId,
      'clusterName': cluster.clusterName,
      'photoURL': cluster.photoURL,
      'timsStamp': cluster.timeStamp,
    });
  }

  // Create and update channel data
  Future<void> updateChannelData(
    Channels channel,
  ) async {
    await clusterCollection.doc(clusterId).collection('channels').doc().set({
      'clusterId': channel.clusterId,
      'channelName': channel.channelName,
      'channelMembers': channel.channelMembers,
      'photoURL': channel.photoURL,
      'timsStamp': channel.timeStamp,
    });
  }

  // Create and update thread data
  Future<void> updateThreadData(
    Threads thread,
  ) async {
    await clusterCollection
        .doc(clusterId)
        .collection('channels')
        .doc(thread.channelId)
        .collection('threads')
        .doc()
        .set({
      'clusterId': thread.channelId,
      'threadName': thread.threadName,
      'isArchived': thread.isArchived,
      'timsStamp': thread.timeStamp,
    });
  }

  // Create and update member data
  Future<void> updateMemberData(
    String? uid,
    String? role,
  ) async {
    await clusterCollection.doc(clusterId).collection('members').doc().set({
      'uid': uid,
      'role': role,
      'timsStamp': timeStamp,
    });
  }

  // Create and update message
  Future<void> updateMessage(
    Messages message,
  ) async {
    await clusterCollection
        .doc(clusterId)
        .collection('cahnnels')
        .doc(channelId)
        .collection('threads')
        .doc(message.threadId)
        .collection('messages')
        .doc(timeStamp.toString())
        .set({
      'sentUid': message.sentUid,
      'content': message.content,
      'threadId': message.threadId,
      'timsStamp': message.timeStamp,
    });
  }

  // Get User Doc Stream
  Stream<UsersData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Cluster Doc Stream
  Stream<Cluster> get clusterData {
    return clusterCollection
        .doc(clusterId)
        .snapshots()
        .map(_clusterDataFromSnapshot);
  }

  // Get Channel Doc Stream
  Stream<Channels> get channelData {
    return clusterCollection
        .doc(clusterId)
        .collection('channels')
        .doc(channelId)
        .snapshots()
        .map(_channelDataFromSnapshot);
  }

  // Get Thread Doc Stream
  Stream<Threads> get threadData {
    return clusterCollection
        .doc(clusterId)
        .collection('channels')
        .doc(channelId)
        .collection('threads')
        .doc(threadId)
        .snapshots()
        .map(_threadDataFromSnapshot);
  }

  // Get Users Doc Stream
  Stream<List<UsersData>> get usersList {
    return usersCollection.snapshots().map(_usersListFromSnapshot);
  }

  // Get Clusters Doc Stream
  Stream<List<Cluster>> get clustersList {
    return clusterCollection.snapshots().map(_clustersListFromSnapshot);
  }

  // Get Channels Doc Stream
  Stream<List<Channels>> get channelsList {
    return clusterCollection
        .doc(clusterId)
        .collection('channels')
        .snapshots()
        .map(_channelsListFromSnapshot);
  }

  // Get Threads Doc Stream
  Stream<List<Threads>> get threadsList {
    return clusterCollection
        .doc(clusterId)
        .collection('channels')
        .doc(channelId)
        .collection('threads')
        .snapshots()
        .map(_threadsListFromSnapshot);
  }

  // Get Messages Doc Stream
  Stream<List<Messages>> get messagesList {
    return clusterCollection
        .doc(clusterId)
        .collection('cahnnels')
        .doc(channelId)
        .collection('threads')
        .doc(threadId)
        .collection('messages')
        .snapshots()
        .map(_messagesListFromSnapshot);
  }

  // User Data from Snapshot
  UsersData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UsersData(
      uid: snapshot['uid'],
      email: snapshot['email'],
      displayName: snapshot['displayName'],
      inCluster: snapshot['inCluster'],
      mobileNo: snapshot['mobileNo'],
      photoURL: snapshot['photoURL'],
      timeStamp: snapshot['timeStamp'],
    );
  }

  // Cluster Data from Snapshot
  Cluster _clusterDataFromSnapshot(DocumentSnapshot snapshot) {
    return Cluster(
      clusterId: snapshot['clusterId'],
      clusterName: snapshot['clusterName'],
      photoURL: snapshot['photoURL'],
      timeStamp: snapshot['timeStamp'],
    );
  }

  // Channel Data from Snapshot
  Channels _channelDataFromSnapshot(DocumentSnapshot snapshot) {
    return Channels(
      clusterId: snapshot['clusterId'],
      channelName: snapshot['channelName'],
      channelMembers: snapshot['channelMembers'],
      photoURL: snapshot['photoURL'],
      timeStamp: snapshot['timeStamp'],
    );
  }

  // Thread Data from Snapshot
  Threads _threadDataFromSnapshot(DocumentSnapshot snapshot) {
    return Threads(
      channelId: snapshot['channelId'],
      threadName: snapshot['threadName'],
      isArchived: snapshot['isArchived'],
      timeStamp: snapshot['timeStamp'],
    );
  }

  // Users List from Snapshot
  List<UsersData> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UsersData.fromDocument(doc);
    }).toList();
  }

  // Clusters List from Snapshot
  List<Cluster> _clustersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cluster.fromDocument(doc);
    }).toList();
  }

  // Channels List from Snapshot
  List<Channels> _channelsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Channels.fromDocument(doc);
    }).toList();
  }

  // Threads List from Snapshot
  List<Threads> _threadsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Threads.fromDocument(doc);
    }).toList();
  }

  // Messages List from Snapshot
  List<Messages> _messagesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Messages.fromDocument(doc);
    }).toList();
  }
}
