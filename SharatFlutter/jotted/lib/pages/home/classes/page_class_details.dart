import 'package:dotted_line/dotted_line.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jotted/models/model_group.dart';
import 'package:flutter/material.dart';
import 'package:jotted/models/model_user.dart';
import 'package:jotted/services/database.dart';
import 'package:provider/provider.dart';

class ClassDetailsPage extends StatelessWidget {
  const ClassDetailsPage({Key? key, required this.group}) : super(key: key);

  final Groups group;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    UsersData user = Provider.of<UsersData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            'Group Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                CircleAvatar(
                  maxRadius: 60,
                  backgroundColor: colorScheme.secondaryVariant,
                  child: Text(group.grupName![0],
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSecondary,
                      )),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Text(
                  '${group.grupName!}'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 0.5,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Created - ${DateFormat('EEE, MMM d, ' 'yy').format(group.timeStamp!)}'
                      .toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                const Divider(
                  endIndent: 12,
                  indent: 12,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.folder,
                    color: colorScheme.primaryVariant,
                  ),
                  title: Text(
                    'Group Media'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.lekton().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primaryVariant,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Visibility(
                  visible: user.isAdmin!,
                  child: const Divider(
                    endIndent: 12,
                    indent: 12,
                  ),
                ),
                Visibility(
                  visible: user.isAdmin!,
                  child: ListTile(
                    leading: Icon(
                      Icons.group_add,
                      color: colorScheme.primaryVariant,
                    ),
                    onTap: () {},
                    title: Text(
                      'Add User'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.lekton().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primaryVariant,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: user.isAdmin!,
                  child: const Divider(
                    endIndent: 12,
                    indent: 12,
                  ),
                ),
                Visibility(
                  visible: user.isAdmin!,
                  child: ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.delete,
                      color: colorScheme.error,
                    ),
                    title: Text(
                      'Delete Group'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.lekton().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.error,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  endIndent: 12,
                  indent: 12,
                ),
                ListTile(
                  leading: Icon(
                    Icons.people,
                    color: colorScheme.primaryVariant,
                  ),
                  title: Text(
                    'Class Members'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: GoogleFonts.lekton().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primaryVariant,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemCount: group.grupUsers!.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<UsersData>(
                          stream: DatabaseService(uid: group.grupUsers![index])
                              .userData,
                          initialData: UsersData.initialData(),
                          builder: (context, snapshot) {
                            String suffix = 'S';

                            if (snapshot.data!.isTeacher!) {
                              suffix = 'T';
                            } else if (snapshot.data!.isAdmin!) {
                              suffix = 'A';
                            }

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                16.0,
                                16.0,
                                16.0,
                                16.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.displayName!,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily:
                                          GoogleFonts.lekton().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      8.0,
                                      5.0,
                                      8.0,
                                      5.0,
                                    ),
                                    child: DottedLine(
                                      dashLength: 3.5,
                                      dashGapLength: 4,
                                      lineThickness: 3.5,
                                      dashColor: colorScheme.primary,
                                      dashRadius: 16,
                                    ),
                                  )),
                                  Text(
                                    suffix,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily:
                                          GoogleFonts.lekton().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      //fontStyle: FontStyle.italic,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
                const SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
