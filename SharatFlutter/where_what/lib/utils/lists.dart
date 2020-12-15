import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  String where, what, discription;
  int prog, index;

  CustomList.home({this.what, this.where}) {
    index = 1;
  }
  /*CustomList.subject(
      {@required this.goal, @required this.prog, @required this.discription}) {
    index = 2;
  }*/

  @override
  Widget build(BuildContext context) {
    //totalProg = prog.toString() + "%";
    switch (index) {
      case 1:
        return homeList();
    }
  }

  Widget homeList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            what,
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            where,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Divider(
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
