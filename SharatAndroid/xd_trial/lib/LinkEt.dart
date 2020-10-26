import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class LinkEt extends StatelessWidget {
  LinkEt({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 344.0, 50.0),
          size: Size(344.0, 50.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.0),
              color: const Color(0xffffffff),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(20.0, 13.0, 48.0, 24.0),
          size: Size(344.0, 50.0),
          pinLeft: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Link',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 20,
              color: const Color(0xffe2e2e2),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
