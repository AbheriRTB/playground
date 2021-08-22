import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protrack/models/subject.dart';
import 'package:protrack/models/topic.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/utils/list.dart';

class SubjectListPage extends StatefulWidget {
  List<Subject> list = [];
  List<Topic> topics = [];

  @override
  _SubjectListPageState createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  String subjID, uid;
  Future<QuerySnapshot> subResultsFuture;
  Future<QuerySnapshot> topicResultsFuture;
  getPosts() async {
    uid = await AuthService().getUID();
    final CollectionReference postCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('subjects');
    Future<QuerySnapshot> posts = postCollection.get();
    QuerySnapshot posts2 = await postCollection.get();

    posts2.docs.forEach((element) {
      setState(() {
        subjID = element.id;
      });
    });
    setState(() {
      subResultsFuture = posts;
    });
  }

  getTopics(subID) async {
    uid = await AuthService().getUID();
    final CollectionReference postCollection1 = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('subjects')
        .doc(subID)
        .collection('topics');
    Future<QuerySnapshot> topics = postCollection1.get();

    setState(() {
      topicResultsFuture = topics;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: subResultsFuture,
          builder: (context, snapshot) {
            Subject subject;
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            widget.list.clear();
            snapshot.data.docs.forEach(
              (doc) {
                subject = Subject.fromDocument(doc);
                print('size =' + widget.list.length.toString());
                widget.list.add(Subject(
                    subID: subject.subID, subjectName: subject.subjectName));
                print(subject.subID);
                //widget.list.add(subject.subjectName);
              },
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
                  child: Text(
                    "Subjects",
                    style: TextStyle(fontSize: 42, color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            getTopics(widget.list[index].subID);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return showOurDialog(index);
                                });
                          },
                          child: CustomList.subject(
                            subject: widget.list[index].subjectName,
                          ),
                        );
                      }),
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.lime,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  Widget showOurDialog(
    int index,
  ) {
    return FutureBuilder(
        future: topicResultsFuture,
        builder: (context, snapshot1) {
          Topic topic;
          if (!snapshot1.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          widget.topics.clear();
          snapshot1.data.docs.forEach(
            (doc) {
              topic = Topic.fromDocument(doc);
              widget.topics.add(Topic(
                  subjectName: topic.subjectName, topicName: topic.topicName));

              //widget.list.add(subject.subjectName);
            },
          );
          return AlertDialog(
            title: Text(widget.list[index].subjectName),
            scrollable: true,
            content: Container(
              height: 200,
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.topics.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomList.subject(
                        subject: widget.topics[index].topicName,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
