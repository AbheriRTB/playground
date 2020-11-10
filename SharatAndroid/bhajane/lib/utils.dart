import 'package:flutter/material.dart';

String lyrics, name, code, Bhajane;


class Shloka extends StatefulWidget {
  Shloka({bhajane shloka}){}
  @override
  _ShlokaState createState() => _ShlokaState();
}

class _ShlokaState extends State<Shloka> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(Bhajane),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.amberAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Next>>",
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class bhajane {
  String lyrics, name, code;
  bhajane({this.lyrics, this.name, this.code});
  void blabla(){}
}
