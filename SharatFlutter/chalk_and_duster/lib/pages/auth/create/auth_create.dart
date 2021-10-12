import 'dart:convert';
import 'dart:io';

import 'package:chalk_and_duster/models/model_%20organization.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:chalk_and_duster/widgets/widget_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

class CreateUsersPage extends StatefulWidget {
  const CreateUsersPage({Key? key}) : super(key: key);

  @override
  _CreateUsersPageState createState() => _CreateUsersPageState();
}

bool? isAvailable = false;
int? numbId;

class _CreateUsersPageState extends State<CreateUsersPage> {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String name = '';
  String password = '';

  String? progBar = 'UPLOAD';
  double? progress;

  String schoolIDHelper = 'Username Unavailable';
  String? id;

  bool loading = false;

  List<List<dynamic>>? fields = [];
  File? file;
  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 60.0,
                    fontFamily: 'Integral',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an org name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  decoration: textInputDecoration("Enter Org Name"),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val!.isNotEmpty ? null : 'Enter an org email',
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  decoration: textInputDecoration(
                    "Enter Org Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.0),
                Divider(
                  color: Colors.grey[900],
                  thickness: 3,
                ),
                Text(
                  error,
                  style: TextStyle(fontSize: 14.0),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              await chooseFile();
                            },
                            child: Text(
                              'DOWNLOAD SAMPLE',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              await chooseFile();
                            },
                            child: Text(
                              '$progBar',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff90D44B),
          child: loading
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(color: Colors.grey[800]))
              : Icon(Icons.meeting_room_sharp, color: Colors.grey[800]),
          onPressed: () async {
            setState(() => loading = true);
            if (_formKey.currentState!.validate()) {
              await createUsers(fields);
            }
          }),
    );
  }

  Future chooseFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      final path = result.files.single.path!;

      setState(() => file = File(path));

      final input = (File(path).openRead());
      fields = await input
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();
      setState(() {
        progBar = 'Selected'.toUpperCase();
      });
    }
  }

  createUsers(List<List<dynamic>>? users) async {
    var randomDoc = FirebaseFirestore.instance.collection('orgnizers').doc().id;

    users!.forEach((element) async {
      setState(() => loading = true);
      bool isAdmin = false, isTeacher = false;

      if (element[5] == 'TRUE') isAdmin = true;
      if (element[6] == 'TRUE') isTeacher = true;

      dynamic result = await _auth.registerWithEmailAndPassword(
        UsersData(
          displayName: element[0],
          email: element[2],
          orgId: randomDoc,
          photoUrl: '',
          isAdmin: isAdmin,
          isTeacher: isTeacher,
          mobileNo: element[4].toString(),
        ),
        element[3],
      );

      if (result == null) {
        setState(() {
          loading = false;
          error = 'Email aldready taklen';
        });
      }
    });

    DatabaseService().updateOrganizationData(Organizations(
      orgName: name,
      orgEmail: email,
      orgId: randomDoc,
    ));
  }
}
