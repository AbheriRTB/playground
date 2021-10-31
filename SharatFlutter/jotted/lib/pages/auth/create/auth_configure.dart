import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jotted/models/model_configure.dart';
import 'package:jotted/models/model_organization.dart';
import 'package:jotted/services/database.dart';

class ConfigurePage extends StatefulWidget {
  ConfigurePage({Key? key, required this.organization}) : super(key: key);

  Organizations organization;

  @override
  State<ConfigurePage> createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {
  bool auth = true;
  bool adress = false;
  bool dob = true;
  bool guardName = true;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Text(
              'User Model',
              style: TextStyle(
                fontSize: 68.0,
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SwitchListTile(
                    value: true,
                    onChanged: null,
                    title: Text('User Name'),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Center(
                    child: Text(
                      'User Authentication Mode',
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  SwitchListTile(
                    value: auth,
                    onChanged: (val) => setState(() => auth = val),
                    title: const Text('Email'),
                    activeColor: colorScheme.primaryVariant,
                  ),
                  SwitchListTile(
                    value: !auth,
                    onChanged: (val) => setState(() => auth = !val),
                    title: const Text('Moile Number'),
                    activeColor: colorScheme.primaryVariant,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Center(
                    child: Text(
                      'Others',
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  SwitchListTile(
                    value: adress,
                    onChanged: (val) => setState(() => adress = val),
                    title: const Text('Adress'),
                    activeColor: colorScheme.primaryVariant,
                  ),
                  SwitchListTile(
                    value: dob,
                    onChanged: (val) => setState(() => dob = val),
                    title: const Text('DOB'),
                    activeColor: colorScheme.primaryVariant,
                  ),
                  SwitchListTile(
                    value: guardName,
                    onChanged: (val) => setState(() => guardName = val),
                    title: const Text('Guardian Name'),
                    activeColor: colorScheme.primaryVariant,
                  ),
                  const SwitchListTile(
                    value: true,
                    onChanged: null,
                    title: Text('User Approval'),
                  ),
                  const SwitchListTile(
                    value: false,
                    onChanged: null,
                    title: Text('Profile Picture'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.arrow_forward,
          ),
          onPressed: () async {
            var randomDoc =
                FirebaseFirestore.instance.collection('organization').doc().id;

            await createOrgs(randomDoc);
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context1) {
                  return AlertDialog(
                    backgroundColor: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Center(
                        child: Text(
                      'DONE!',
                      style: TextStyle(
                        fontFamily: GoogleFonts.lekton().fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                        color: colorScheme.onSurface,
                      ),
                    )),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Congrats! Organization ${widget.organization.orgName} Has been created Successfully. In order to join into the same, you wold need to register an account with the Organization id. The first user to login will be the default admin. The Organization id must be only given to those in it, in order to maintain the privicy'
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.lekton().fontFamily,
                            fontSize: 18.0,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Organization ID $randomDoc'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                            fontFamily: GoogleFonts.lekton().fontFamily,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Clipboard.setData(ClipboardData(text: randomDoc)),
                        child: Text('Copy'.toUpperCase()),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context1);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: Text('Continue'.toUpperCase()),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  createOrgs(String randomDoc) async {
    await DatabaseService().updateOrganizationData(
      widget.organization,
      Configure(
        userName: true,
        authMode: auth,
        adress: adress,
        dob: dob,
        guardianName: guardName,
        userApproval: true,
        profilePicture: false,
      ),
      randomDoc,
    );
  }
}
