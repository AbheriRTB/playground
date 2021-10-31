import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth_register.dart';

class OrgIdEnroll extends StatefulWidget {
  const OrgIdEnroll({Key? key}) : super(key: key);

  @override
  _OrgIdEnrollState createState() => _OrgIdEnrollState();
}

class _OrgIdEnrollState extends State<OrgIdEnroll> {
  bool error = false;
  String? orgId = 'EfoOw0uO6ZRmXCS0684S';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 32.0),
              Text(
                'Enter the Organization ID',
                style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondary),
              ),
              const SizedBox(
                height: 64,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter Org ID' : null,
                onChanged: (val) {
                  setState(() => orgId = val.trim());
                },
                decoration: InputDecoration(
                  filled: false,
                  focusedBorder: const UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                    ),
                  ),
                  hintText: "Enter Org ID",
                  hintStyle: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 28.0,
                    fontFamily: GoogleFonts.lekton().fontFamily,
                  ),
                  hintMaxLines: null,
                ),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 28.0,
                  fontFamily: GoogleFonts.lekton().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              const SizedBox(
                height: 24,
              ),
              AnimatedOpacity(
                opacity: error ? 1 : 0,
                duration: const Duration(seconds: 1),
                child: Text(
                  "Organization dosen't exist!",
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: 28.0,
                    fontFamily: GoogleFonts.lekton().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_forward,
        ),
        onPressed: () async {
          QuerySnapshot ds = await FirebaseFirestore.instance
              .collection('organization')
              .where('orgId', isEqualTo: orgId)
              .get();
          setState(() {
            print(ds.docs);
            error = ds.docs.isEmpty;
          });

          if (_formKey.currentState!.validate() && !error) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterPage(orgID: orgId!)));
          }
        },
      ),
    );
  }
}
