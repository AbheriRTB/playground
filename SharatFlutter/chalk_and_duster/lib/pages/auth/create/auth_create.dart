import 'dart:convert';
import 'dart:io';

import 'package:chalk_and_duster/models/model_%20organization.dart';
import 'package:chalk_and_duster/models/model_user.dart';
import 'package:chalk_and_duster/pages/auth/loading.dart';
import 'package:chalk_and_duster/services/auth.dart';
import 'package:chalk_and_duster/services/database.dart';
import 'package:chalk_and_duster/widgets/text_field.dart';
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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: primary,
            //resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'REGISTER ORG',
                        style: TextStyle(
                          fontSize: 38.0,
                          color: accentDark,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an org name' : null,
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
                      TextFormField(
                        validator: (val) =>
                            val!.isNotEmpty ? null : 'Enter School ID',
                        onChanged: (val) async {
                          setState(() => id = val);
                          await checkExist(val);
                        },
                        decoration: textInputDecoration(
                          "Enter School ID",
                          indicator: isAvailable!
                              ? 'Username Available'
                              : 'Username Unavailable',
                          color: isAvailable! ? Colors.green : Colors.red,
                          //suffix: '#$numbId'
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Divider(
                        color: accent,
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
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () async {},
                                  color: secondary,
                                  child: Text(
                                    'DOWNLOAD EXAMPLE',
                                    style: TextStyle(color: accentDark),
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
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () async {
                                    await chooseFile();
                                  },
                                  color: secondary,
                                  child: Text(
                                    '$progBar',
                                    style: TextStyle(color: accentDark),
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

            floatingActionButton: FloatingActionButton.extended(
                label: Text("Register"),
                backgroundColor: accent,
                onPressed: () async {
                  if (isAvailable!) {
                    await createUsers(fields);
                  } else {}
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
      setState(() {});
    }
  }

  createUsers(List<List<dynamic>>? users) async {
    users!.forEach((element) async {
      setState(() => loading = true);
      bool isAdmin = false, isTeacher = false;

      if (element[5] == 'TRUE') isAdmin = true;
      if (element[6] == 'TRUE') isTeacher = true;

      dynamic result = await _auth.registerWithEmailAndPassword(
        UsersData(
          displayName: element[0],
          email: element[2],
          orgId: id!,
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
      orgId: id,
    ));
  }

  static Future<bool> checkExist(String docID) async {
    print(isAvailable);
    try {
      await FirebaseFirestore.instance
          .collection('orgnizers')
          .doc(docID)
          .get()
          .then((doc) {
        isAvailable = !doc.exists;
        print(isAvailable);
      });

      return isAvailable!;
    } catch (e) {
      // If any error
      print(e);
      return false;
    }
  }
}
