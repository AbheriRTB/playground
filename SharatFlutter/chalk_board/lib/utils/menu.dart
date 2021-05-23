import 'package:chalk_board/services/auth.dart';
import 'package:chalk_board/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.grey[900],
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            //leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.red[900],
                  fontFamily: GoogleFonts.indieFlower().fontFamily,
                  fontSize: 20.0),
            ),
            onTap: () {
              AuthService().signOut();
            },
          ),
        ),
      ],
    );
  }
}
