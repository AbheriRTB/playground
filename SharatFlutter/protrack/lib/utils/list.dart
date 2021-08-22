import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  String goal, totalProg, discription, subject, desc;
  int prog, index;
  Function onTap;

  CustomList.goal({this.goal, this.prog}) {
    index = 1;
  }
  CustomList.subject({
    this.subject,
    this.desc,
    this.onTap,
  }) {
    index = 2;
  }

  @override
  Widget build(BuildContext context) {
    totalProg = prog.toString() + "%";
    switch (index) {
      case 1:
        return goalList();
      case 2:
        return subjectList();
    }
  }

  Widget goalList() {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    goal,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            new Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0),
              child: Text(
                totalProg,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
        Divider(
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }

  Widget subjectList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
            child: Text(
              subject,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Text(
            desc,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),*/
        Divider(
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
