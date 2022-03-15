import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jotted/models/model_organization.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/database.dart';
import 'package:provider/provider.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    UsersData user = Provider.of<UsersData>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 38.0, horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Approvals',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('orgId', isEqualTo: user.orgId)
                    .where('approved', isEqualTo: false)
                    .snapshots(),
                initialData: null,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    debugPrint(snapshot.error.toString());
                    return const CircularProgressIndicator();
                  }

                  return Expanded(
                    child: snapshot.data!.docs.isEmpty
                        ? Center(
                            child: Text('No approvals left'.toUpperCase()),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return CardWidget(
                                adminTap: () async {
                                  await DatabaseService(
                                          uid: snapshot.data!.docs[index]
                                              ['uid'])
                                      .approveUserData(false, true);
                                },
                                name: snapshot.data!.docs[index]['displayName'],
                                studentTap: () async {
                                  await DatabaseService(
                                          uid: snapshot.data!.docs[index]
                                              ['uid'])
                                      .approveUserData(false, false);
                                },
                                teacherTap: () async {
                                  await DatabaseService(
                                          uid: snapshot.data!.docs[index]
                                              ['uid'])
                                      .approveUserData(true, false);
                                },
                                uid: snapshot.data!.docs[index]['uid'],
                              );
                            }),
                  );
                }),
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
    required this.uid,
    required this.name,
    required this.adminTap,
    required this.studentTap,
    required this.teacherTap,
  }) : super(key: key);

  String uid;
  String name;
  VoidCallback teacherTap;
  VoidCallback adminTap;
  VoidCallback studentTap;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: const Color(0xffE4F0D7),
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uid,
                    style: TextStyle(
                      overflow: TextOverflow.fade,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: colorScheme.onSurface,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    name,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 21,
                      color: Colors.grey[800],
                      fontFamily: GoogleFonts.lekton().fontFamily,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: teacherTap,
                          child: Text(
                            'teacher'.toUpperCase(),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        TextButton(
                          onPressed: adminTap,
                          child: Text(
                            'admin'.toUpperCase(),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: studentTap,
                          child: Text(
                            'student'.toUpperCase(),
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
      ),
    );
  }
}
