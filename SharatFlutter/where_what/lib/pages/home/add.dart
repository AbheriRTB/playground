import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:where_what/models/where.dart';
import 'package:where_what/pages/home/list.dart';
import 'package:where_what/services/auth.dart';
import 'package:where_what/utils/text_field.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final AuthService _auth = AuthService();

  final myWhatController = TextEditingController();
  final myWhereController = TextEditingController();
  String where, wha, finalDate = '';
  Where mapWhere;
  @override
  Widget build(BuildContext context) {
    getDate();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ListPage()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.red[100],
              ),
            ),
          ],
        ),
        color: Colors.red,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add"),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            addWhere(myWhatController.text, myWhereController.text);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 12.0),
            child: Column(
              children: [
                Text(
                  "NEW ITEM",
                  style: TextStyle(
                      fontSize: 54,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 32, 14, 24),
                        child: DefaultTextField(
                          controller: myWhatController,
                          label: 'What',
                          validate: 'Enter What?',
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
                          child: DefaultTextField(
                            controller: myWhereController,
                            label: 'Where',
                            validate: 'Enter Where?',
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
                  child: Text(
                    "NOTE: Only as of today your object is recorded in that location." +
                        " You can always change it's location",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 36.0, 24.0, 8.0),
                  child: Text(
                    finalDate,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  void addWhere(String where, String what) async {
    getDate();
    dynamic result = await _auth.addData(where, what, finalDate);
    //dynamic result = DatabaseService(uid: uid).addWhere(where, what, finalDate);
    if (result == null) {
      setState(() {
        print("error");
      });
    }

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ListPage()));
  }
}
