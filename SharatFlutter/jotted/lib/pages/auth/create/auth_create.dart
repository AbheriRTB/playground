import 'dart:convert';
import 'dart:io';

import 'package:jotted/models/model_organization.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/pages/auth/create/auth_configure.dart';
import 'package:jotted/services/auth.dart';
import 'package:jotted/widgets/widget_text_field.dart';
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
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String name = '';
  String email = '';
  String contact = '';
  String country = '';
  String city = '';
  String adress = '';
  String branch = '';

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
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 32.0),
              Text(
                'Join Us',
                style: TextStyle(
                  fontSize: 68.0,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter Org Name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                      decoration: textInputDecoration("Enter Org Name"),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (val) =>
                          val!.isNotEmpty ? null : 'Enter Org Email',
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: textInputDecoration(
                        "Enter Org Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (val) =>
                          val!.isNotEmpty ? null : 'Enter Contact No.',
                      onChanged: (val) {
                        setState(() => contact = val);
                      },
                      decoration: textInputDecoration(
                        "Enter Contact No.",
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (val) =>
                          val!.isNotEmpty ? null : 'Enter Country',
                      onChanged: (val) {
                        setState(() => country = val);
                      },
                      decoration: textInputDecoration(
                        "Enter Country",
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (val) => val!.isNotEmpty ? null : 'Enter City',
                      onChanged: (val) {
                        setState(() => city = val);
                      },
                      decoration: textInputDecoration(
                        "Enter City",
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      onChanged: (val) {
                        setState(() => adress = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Enter Org Adress (Optional)",
                        alignLabelWithHint: true,
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      onChanged: (val) {
                        setState(() => branch = val);
                      },
                      decoration: const InputDecoration(
                        labelText: "Enter Branch (Optional)",
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              Text(
                error,
                style: const TextStyle(fontSize: 14.0),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUsersPage()));
                  },
                  child: Text(
                    'Need help? Contact us.',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.arrow_forward,
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfigurePage(
                            organization: Organizations(
                              orgAdress: adress,
                              orgBranch: branch,
                              orgCity: city,
                              orgContact: contact,
                              orgCountry: country,
                              orgEmail: email,
                              orgName: name,
                            ),
                          )));
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

    /* DatabaseService().updateOrganizationData(Organizations(
      orgName: name,
      orgEmail: email,
      orgId: randomDoc,
    ));*/
  }
}
