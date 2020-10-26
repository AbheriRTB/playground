import 'package:flutter/material.dart';
import './Component81.dart';

class About extends StatelessWidget {
  About({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-60.0, -73.0),
            child: SizedBox(
              width: 576.0,
              height: 416.0,
              child: Component81(),
            ),
          ),
        ],
      ),
    );
  }
}
