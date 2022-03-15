import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:jotted/models/model_organization.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/auth.dart';
import 'package:jotted/services/database.dart';
import 'package:jotted/widgets/widget_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key, required this.orgID}) : super(key: key);

  String orgID;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? password;
  String? name;
  String? email;
  String? guardianName;
  String? adress;
  String? mobNo;
  bool _showPass = true;
  DateTime? date;

  Organizations? organizations;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<Organizations>(
            stream: DatabaseService(orgId: widget.orgID).orgsData,
            initialData: Organizations.initialData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return const CircularProgressIndicator();
              }

              organizations = snapshot.data!;

              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 46.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 32.0),
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Visibility(
                        visible: organizations!.configurations!['userName'],
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter User Name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                          decoration: textInputDecoration("Enter User Name"),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      organizations!.configurations!['authMode']
                          ? TextFormField(
                              validator: (val) =>
                                  val!.isNotEmpty ? null : 'Enter Email',
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              decoration: textInputDecoration(
                                "Enter Email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                            )
                          : TextFormField(
                              validator: (val) =>
                                  val!.isNotEmpty ? null : 'Enter Mobile No.',
                              onChanged: (val) {
                                setState(() => mobNo = val);
                              },
                              decoration: textInputDecoration(
                                "Enter Mobile No.",
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                      const SizedBox(height: 16.0),
                      Visibility(
                        visible: organizations!.configurations!['guardianName'],
                        child: TextFormField(
                          validator: (val) =>
                              val!.isNotEmpty ? null : 'Enter Guardian Name',
                          onChanged: (val) {
                            setState(() => guardianName = val);
                          },
                          decoration: textInputDecoration(
                            "Enter Guardian Name",
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Visibility(
                        visible: organizations!.configurations!['adress'],
                        child: TextFormField(
                          validator: (val) =>
                              val!.isNotEmpty ? null : 'Enter Adress',
                          onChanged: (val) {
                            setState(() => adress = val);
                          },
                          decoration: const InputDecoration(
                            labelText: "Enter Adress",
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Visibility(
                        visible: organizations!.configurations!['dob'],
                        child: TextFormField(
                          validator: (val) =>
                              (date != null) ? null : 'Enter DOB',
                          onChanged: null,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            date = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            ))!;
                          },
                          decoration: InputDecoration(
                            labelText: date != null
                                ? DateFormat('dd/MM/yy').format(date!)
                                : 'Enter DOB',
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Visibility(
                        visible: organizations!.configurations!['authMode'],
                        child: TextFormField(
                          obscureText: _showPass,
                          validator: (val) => val!.length < 8
                              ? 'Enter a password 8+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            suffixIcon: IconButton(
                              icon: Icon(_showPass
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _showPass = !_showPass;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Visibility(
                        visible: organizations!.configurations!['authMode'],
                        child: TextFormField(
                          obscureText: _showPass,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Re-Enter New Password";
                            } else if (val != password) {
                              return "Password must be same as above";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: textInputDecoration("Conform Password"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.arrow_forward,
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              QuerySnapshot ds = await FirebaseFirestore.instance
                  .collection('users')
                  .where('orgId', isEqualTo: organizations!.orgId)
                  .get();
              bool isFirst = ds.docs.isEmpty;

              organizations!.configurations!['authMode']
                  ? AuthService().registerWithEmailAndPassword(
                      UsersData(
                        adress: adress,
                        displayName: name,
                        dob: date,
                        email: email,
                        guardianName: guardianName,
                        isAdmin: isFirst ? true : false,
                        isTeacher: false,
                        mobileNo: mobNo,
                        orgId: organizations!.orgId,
                        approved: isFirst ? true : false,
                      ),
                      organizations!,
                      password!)
                  : null;
            }
          }),
    );
  }
}
