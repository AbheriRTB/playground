import 'package:flutter/material.dart';
import 'package:protrack/services/auth.dart';
import 'package:protrack/services/database.dart';

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController tcName = TextEditingController();
    final TextEditingController tcDescription = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Form(
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
                  validator: (val) => val.isEmpty ? 'Enter an name' : null,
                  decoration: InputDecoration(
                    labelText: "Subject Name",
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
              ],
            ),
          ),
        ),
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
            creatSubjects(tcName.text, desc);
            Navigator.pop(
              context,
            );
          }
        },
        icon: Icon(Icons.add),
        label: Text("CREATE SUBJECT"),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void creatSubjects(String name, String description) async {
    String uid = await AuthService().getUID();
    await DatabaseService(uid: uid).createSubject(
      name,
      description,
    );
  }
}
