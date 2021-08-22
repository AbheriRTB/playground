import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:protrack/models/subject.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/services/database.dart';
import 'package:provider/provider.dart';

class AddTopicPage extends StatefulWidget {
  List<Subject> list = [];
  Subject selected;

  @override
  _AddTopicPageState createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  Subject _selectedId;
  Future<QuerySnapshot> postResultsFuture;
  String subjID, uid;
  List<Subject> subjects = [];

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
      print(subjID);
    });
    setState(() {
      postResultsFuture = posts;
    });
  }

  @override
  void initState() {
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tcName = TextEditingController();
    final TextEditingController tcDescription = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: postResultsFuture,
            builder: (context, snapshot) {
              Subject subject;
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              snapshot.data.docs.forEach(
                (doc) {
                  subject = Subject.fromDocument(doc);
                  widget.list.add(Subject(
                      subID: subject.subID, subjectName: subject.subjectName));
                },
              );

              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add",
                        style: TextStyle(fontSize: 56, color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: tcName,
                        validator: (val) =>
                            val.isEmpty ? 'Enter an name' : null,
                        decoration: InputDecoration(
                          labelText: "Topic Name",
                          icon: Icon(Icons.flag),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: tcDescription,
                        decoration: InputDecoration(
                          labelText: "Description",
                          icon: Icon(Icons.description),
                        ),
                      ),
                      ListView(
                          padding: const EdgeInsets.all(32.0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10.0),
                                child: DropdownButtonFormField<Subject>(
                                  validator: (val) => _selectedId == null
                                      ? 'Select Subject'
                                      : null,
                                  hint: Text("Pick a subject"),
                                  value: _selectedId,
                                  onChanged: (Subject value) {
                                    setState(() {
                                      _selectedId = value;
                                    });
                                  },
                                  items: widget.list.map((Subject value) {
                                    return new DropdownMenuItem<Subject>(
                                      value: value,
                                      child: new Text(value.subjectName),
                                    );
                                  }).toList(),
                                )),
                          ]),
                    ],
                  ),
                ),
              );
            }),
      ),

      // AppBar
      bottomNavigationBar: new BottomAppBar(
        color: Colors.lime,

        // Menu
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Anchor
        //shape: CircularNotchedRectangle(),
      ),

      // Fab
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String desc = "";
          desc = tcDescription.text;
          if (_formKey.currentState.validate()) {
            creatTopics(
                tcName.text, desc, _selectedId.subjectName, _selectedId.subID);
            Navigator.pop(
              context,
            );
          }
        },
        icon: Icon(Icons.add),
        label: Text("CREATE TOPIC"),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void creatTopics(
    String name,
    String description,
    String subject,
    String subID,
  ) async {
    String uid = await AuthService().getUID();
    await DatabaseService(uid: uid).createTopic(
      name,
      description,
      subject,
      subID,
    );
  }
}
