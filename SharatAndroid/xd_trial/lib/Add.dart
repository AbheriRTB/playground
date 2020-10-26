import 'package:flutter/material.dart';
import './NameEt.dart';
import './LinkEt.dart';
import './DateBtn.dart';
import './CancleBtn.dart';
import './ActionBar.dart';
import './FloatingBtn.dart';

class Add extends StatelessWidget {
  Add({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(34.0, 443.0),
            child:
                // Adobe XD layer: 'NameEt' (component)
                SizedBox(
              width: 344.0,
              height: 50.0,
              child: NameEt(),
            ),
          ),
          Transform.translate(
            offset: Offset(34.0, 508.0),
            child:
                // Adobe XD layer: 'LinkEt' (component)
                SizedBox(
              width: 344.0,
              height: 50.0,
              child: LinkEt(),
            ),
          ),
          Transform.translate(
            offset: Offset(34.0, 573.0),
            child:
                // Adobe XD layer: 'DateBtn' (component)
                SizedBox(
                  chi
              width: 90.0,
              height: 50.0,
              child: DateBtn(),
            ),
          ),
          Transform.translate(
            offset: Offset(36.0, 796.0),
            child:
                // Adobe XD layer: 'CancleBtn' (component)
                SizedBox(
              width: 72.0,
              height: 24.0,
              child: CancleBtn(),
            ),
          ),
          Transform.translate(
            offset: Offset(-327.1, -174.0),
            child:
                // Adobe XD layer: 'ActionBar' (component)
                SizedBox(
              width: 843.0,
              height: 571.0,
              child: ActionBar(),
            ),
          ),
          Transform.translate(
            offset: Offset(318.0, 778.0),
            child:
                // Adobe XD layer: 'FloatingBtn' (component)
                SizedBox(
              width: 60.0,
              height: 60.0,
              child: FloatingBtn(),
            ),
          ),
        ],
      ),
    );
  }
}
